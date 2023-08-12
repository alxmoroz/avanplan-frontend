// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/estimate_value.dart';
import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../L1_domain/entities_extensions/ws_estimates.dart';
import '../../../../L1_domain/usecases/task_comparators.dart';
import '../../../components/constants.dart';
import '../../../components/mt_dialog.dart';
import '../../../components/mt_field_data.dart';
import '../../../components/mt_select_dialog.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/person_presenter.dart';
import '../../../presenters/task_type_presenter.dart';
import '../../../presenters/task_view_presenter.dart';
import '../../../presenters/ws_presenter.dart';
import '../../../usecases/task_available_actions.dart';
import '../../../usecases/task_edit.dart';
import '../../../views/_base/edit_controller.dart';
import '../widgets/task_description_dialog.dart';
import '../widgets/transfer/select_task_dialog.dart';
import 'add_controller.dart';
import 'dates_controller.dart';
import 'notes_controller.dart';
import 'status_controller.dart';

part 'task_controller.g.dart';

// TODO: уменьшить размер файла, разнести по отдельным контроллерам

enum TaskTabKey { overview, subtasks, details, team }

enum TaskFCode { parent, title, status, assignee, description, startDate, dueDate, estimate, author, note }

enum TasksFilter { my }

class TaskController extends _TaskControllerBase with _$TaskController {
  TaskController(Task taskIn) {
    initState(fds: [
      MTFieldData(TaskFCode.parent.index),
      MTFieldData(TaskFCode.status.index),
      MTFieldData(TaskFCode.title.index, text: taskIn.isNew ? '' : taskIn.title),
      MTFieldData(TaskFCode.assignee.index, label: loc.task_assignee_label, placeholder: loc.task_assignee_placeholder),
      MTFieldData(TaskFCode.description.index, text: taskIn.description, label: loc.description, placeholder: loc.description),
      MTFieldData(TaskFCode.startDate.index, label: loc.task_start_date_label, placeholder: loc.task_start_date_placeholder),
      MTFieldData(TaskFCode.dueDate.index, label: loc.task_due_date_label, placeholder: loc.task_due_date_placeholder),
      MTFieldData(
        TaskFCode.estimate.index,
        label: taskIn.estimate != null ? loc.task_estimate_label : loc.task_estimate_group_label,
        placeholder: loc.task_estimate_placeholder,
      ),
      MTFieldData(TaskFCode.author.index, label: loc.task_author_title, placeholder: loc.task_author_title),
      MTFieldData(TaskFCode.note.index, placeholder: loc.task_note_placeholder),
    ]);

    _init(taskIn);

    addController = AddController(taskIn.ws, this);
    statusController = StatusController(this);
    datesController = DatesController(this);
    notesController = NotesController(this);
  }
}

abstract class _TaskControllerBase extends EditController with Store {
  Task get task => mainController.task(_task!.ws.id!, _task!.id) ?? _task!;
  Workspace get _ws => task.ws;

  late final AddController addController;
  late final StatusController statusController;
  late final DatesController datesController;
  late final NotesController notesController;

  @observable
  Task? _task;

  @action
  Future _init(Task _taskIn) async {
    _task = _taskIn;

    if (isNew) {
      await saveField(TaskFCode.title);
    }
  }

  @computed
  bool get isNew => _task?.isNew == true;

  @action
  Future<bool> saveField(TaskFCode code) async {
    updateField(code.index, loading: true);
    final et = await _task?.save();
    final saved = et != null;
    if (saved) {
      _task = et;
    }
    updateField(code.index, loading: false);
    return saved;
  }

  /// название

  String get titlePlaceholder => newSubtaskTitle(task.parent?.type ?? TType.ROOT);

  Future _setTitle(String str) async {
    if (task.title != str) {
      if (str.trim().isEmpty) {
        str = titlePlaceholder;
      }
      final oldValue = task.title;
      task.title = str;
      if (!(await saveField(TaskFCode.title))) {
        task.title = oldValue;
      }
    }
  }

  Timer? _titleEditTimer;

  Future editTitle(String str) async {
    if (_titleEditTimer != null) {
      _titleEditTimer!.cancel();
    }
    _titleEditTimer = Timer(const Duration(milliseconds: 800), () async => await _setTitle(str));
  }

  /// назначенный

  Future _resetAssignee() async {
    final oldValue = task.assigneeId;
    task.assigneeId = null;
    if (!(await saveField(TaskFCode.assignee))) {
      task.assigneeId = oldValue;
    }
  }

  Future assignPerson() async {
    final selectedId = await showMTSelectDialog<Member>(
      task.activeMembers,
      task.assigneeId,
      loc.task_assignee_placeholder,
      valueBuilder: (_, member) => member.iconName(radius: P * 1.5),
      onReset: task.canAssign ? _resetAssignee : null,
    );
    if (selectedId != null) {
      final oldValue = task.assigneeId;
      task.assigneeId = selectedId;
      if (!(await saveField(TaskFCode.assignee))) {
        task.assigneeId = oldValue;
      }
    }
  }

  /// описание

  Future editDescription() async {
    final tc = teController(TaskFCode.description.index)!;
    await showMTDialog<void>(TaskDescriptionDialog(tc));
    final newValue = tc.text;
    if (task.description != newValue) {
      final oldValue = task.description;
      task.description = newValue;
      if (!(await saveField(TaskFCode.description))) {
        task.description = oldValue;
      }
    }
  }

  /// оценка

  Future _resetEstimate() async {
    final oldValue = task.estimate;
    task.estimate = null;
    if (!(await saveField(TaskFCode.estimate))) {
      task.estimate = oldValue;
    }
  }

  Future selectEstimate() async {
    final currentId = _ws.estimateValueForValue(task.estimate)?.id;
    final selectedEstimateId = await showMTSelectDialog<EstimateValue>(
      _ws.sortedEstimateValues,
      currentId,
      loc.task_estimate_placeholder,
      valueBuilder: (_, e) {
        final selected = currentId == e.id;
        final text = '${e.value}';
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected) const SizedBox(width: P),
            selected ? H3(text) : NormalText(text),
            LightText(' ${_ws.estimateUnitCode}'),
          ],
        );
      },
      onReset: _resetEstimate,
    );

    if (selectedEstimateId != null) {
      final oldValue = task.estimate;
      task.estimate = _ws.estimateValueForId(selectedEstimateId)?.value;
      if (!(await saveField(TaskFCode.estimate))) {
        task.estimate = oldValue;
      }
    }
  }

  /// перенос с другую цель

  Future localExport() async {
    final sourceGoal = task.parent!;
    final destinationGoalId = await selectTaskDialog(
      task.goalsForLocalExport.sorted(sortByDateAsc),
      loc.task_transfer_destination_hint,
    );

    if (destinationGoalId != null) {
      final destinationGoal = task.goalsForLocalExport.firstWhere((g) => g.id == destinationGoalId);
      task.parent = destinationGoal;
      if (!(await saveField(TaskFCode.parent))) {
        task.parent = sourceGoal;
      } else {
        sourceGoal.tasks.removeWhere((t) => t.id == task.id);
        destinationGoal.tasks.add(task);
        mainController.refresh();
      }
    }
  }

  /// вкладки

  @computed
  Iterable<TaskTabKey> get tabKeys {
    return [
      if (!isNew && task.hasOverviewPane) TaskTabKey.overview,
      if (!isNew && task.hasSubtasks) TaskTabKey.subtasks,
      if (!isNew && task.hasTeamPane) TaskTabKey.team,
      TaskTabKey.details,
    ];
  }

  @observable
  TaskTabKey? _tabKey;
  @action
  void selectTab(TaskTabKey? tk) => _tabKey = tk;

  @computed
  TaskTabKey get tabKey => (tabKeys.contains(_tabKey) ? _tabKey : null) ?? (tabKeys.isNotEmpty ? tabKeys.first : TaskTabKey.subtasks);

  /// режим Доска / Список

  @observable
  bool showBoard = false;

  @action
  void toggleMode() => showBoard = !showBoard;
}
