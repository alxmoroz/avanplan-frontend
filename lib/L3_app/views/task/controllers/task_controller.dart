// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../main.dart';
import '../../../components/field_data.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_view.dart';
import '../../../usecases/task_edit.dart';
import '../../../views/_base/edit_controller.dart';
import 'assignee_controller.dart';
import 'create_controller.dart';
import 'dates_controller.dart';
import 'estimate_controller.dart';
import 'local_export_controller.dart';
import 'notes_controller.dart';
import 'status_controller.dart';
import 'subtasks_controller.dart';
import 'title_controller.dart';

part 'task_controller.g.dart';

// TODO: уменьшить размер файла, разнести по отдельным контроллерам

enum TaskTabKey { overview, subtasks, details, team }

enum TaskFCode { parent, title, status, assignee, description, startDate, dueDate, estimate, author, features, note }

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
        label: taskIn.openedVolume != null ? loc.task_estimate_group_label : loc.task_estimate_label,
        placeholder: loc.task_estimate_placeholder,
      ),
      MTFieldData(TaskFCode.author.index, label: loc.task_author_title, placeholder: loc.task_author_title),
      MTFieldData(TaskFCode.features.index, label: loc.project_feature_sets_label),
      MTFieldData(TaskFCode.note.index, placeholder: loc.task_note_placeholder),
    ]);

    _init(taskIn);

    createController = CreateController(taskIn.ws, this);
    titleController = TitleController(this);
    assigneeController = AssigneeController(this);
    statusController = StatusController(this);
    datesController = DatesController(this);
    estimateController = EstimateController(this);
    notesController = NotesController(this);
    transferController = LocalExportController(this);
    subtasksController = SubtasksController(this);
  }
}

abstract class _TaskControllerBase extends EditController with Store {
  Task get task => mainController.task(_task!.ws.id!, _task!.id) ?? _task!;

  late final CreateController createController;
  late final TitleController titleController;
  late final AssigneeController assigneeController;
  late final StatusController statusController;
  late final DatesController datesController;
  late final EstimateController estimateController;
  late final NotesController notesController;
  late final LocalExportController transferController;
  late final SubtasksController subtasksController;

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
    final et = await task.save();
    final saved = et != null;
    if (saved) {
      _task = et;
    }
    updateField(code.index, loading: false);
    return saved;
  }

  /// вкладки

  @computed
  Iterable<TaskTabKey> get tabKeys {
    return [
      if (!isNew && task.hasOverviewPane) TaskTabKey.overview,
      if (!isNew && !task.isTask) TaskTabKey.subtasks,
      if (!isNew && task.hasTeamPane) TaskTabKey.team,
      TaskTabKey.details,
    ];
  }

  @observable
  TaskTabKey? _tabKey;
  @action
  void selectTab(TaskTabKey? tk) {
    _tabKey = tk;
    FocusScope.of(rootKey.currentContext!).unfocus();
  }

  @computed
  TaskTabKey get tabKey => (tabKeys.contains(_tabKey) ? _tabKey : null) ?? (tabKeys.isNotEmpty ? tabKeys.first : TaskTabKey.subtasks);

  /// режим Доска / Список

  @observable
  bool showBoard = false;
  @action
  void toggleMode() => showBoard = !showBoard;
}
