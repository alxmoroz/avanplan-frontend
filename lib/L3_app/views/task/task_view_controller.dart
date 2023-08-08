// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/estimate_value.dart';
import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../../L1_domain/entities_extensions/task_members.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../L1_domain/entities_extensions/task_status_ext.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../../L1_domain/system/errors.dart';
import '../../../L1_domain/usecases/task_comparators.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_alert_dialog.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_field_data.dart';
import '../../components/mt_select_dialog.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../../presenters/duration_presenter.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/task_type_presenter.dart';
import '../../presenters/task_view_presenter.dart';
import '../../presenters/ws_presenter.dart';
import '../../usecases/task_available_actions.dart';
import '../../views/_base/edit_controller.dart';
import 'widgets/task_description_dialog.dart';
import 'widgets/transfer/select_task_dialog.dart';

part 'task_view_controller.g.dart';

// TODO: уменьшить размер файла, разнести по отдельным контроллерам. Например, отдельно редактирование и просмотр

enum TaskTabKey { overview, subtasks, details, team }

enum TaskFCode { title, description, startDate, dueDate, estimate, assignee, author, parent, note }

enum TasksFilter { my }

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {
  TaskViewController(Task taskIn) {
    _setTask(taskIn);

    initState(fds: [
      MTFieldData(TaskFCode.parent.index, needValidate: false),
      MTFieldData(
        TaskFCode.title.index,
        text: isNew ? '' : task.title,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.description.index,
        text: task.description,
        label: loc.description,
        placeholder: loc.description,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.startDate.index,
        label: loc.task_start_date_label,
        placeholder: loc.task_start_date_placeholder,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.dueDate.index,
        label: loc.task_due_date_label,
        placeholder: loc.task_due_date_placeholder,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.estimate.index,
        label: task.estimate != null ? loc.task_estimate_label : loc.task_estimate_group_label,
        placeholder: loc.task_estimate_placeholder,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.assignee.index,
        label: loc.task_assignee_label,
        placeholder: loc.task_assignee_placeholder,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.author.index,
        label: loc.task_author_title,
        placeholder: loc.task_author_title,
        needValidate: false,
      ),
      MTFieldData(TaskFCode.note.index, placeholder: loc.task_note_placeholder, needValidate: false),
    ]);

    _startupActions();
  }
}

abstract class _TaskViewControllerBase extends EditController with Store {
  Task get task => isNew ? _taskIn! : mainController.task(_taskIn!.ws.id!, _taskIn!.id!);
  Workspace get _ws => task.ws;

  Future _startupActions() async {
    if (isNew) {
      await _saveField(TaskFCode.title);
    }
  }

  @observable
  Task? _taskIn;

  @action
  void _setTask(Task task) {
    _taskIn = task;
  }

  @computed
  bool get isNew => _taskIn?.id == null;

  @action
  Future<bool> _saveField(TaskFCode code) async {
    bool saved = false;
    updateField(code.index, loading: true);
    try {
      final editedTask = await taskUC.save(_ws, task);
      saved = editedTask != null;
      if (saved) {
        if (isNew) {
          if (task.parent != null) {
            task.parent!.tasks.add(editedTask);
          }
          mainController.allTasks.add(editedTask);
          _setTask(editedTask);
        } else
          mainController.refreshTask(editedTask);
      }
    } catch (e) {
      task.error = MTError(loader.titleText ?? '', detail: loader.descriptionText);
      mainController.refresh();
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
      if (!(await _saveField(TaskFCode.title))) {
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

  /// описание

  Future editDescription() async {
    final tc = teController(TaskFCode.description.index)!;
    await showMTDialog<void>(TaskDescriptionDialog(tc));
    final newValue = tc.text;
    if (task.description != newValue) {
      final oldValue = task.description;
      task.description = newValue;
      if (!(await _saveField(TaskFCode.description))) {
        task.description = oldValue;
      }
    }
  }

  /// назначенный

  Future _resetAssignee() async {
    final oldValue = task.assigneeId;
    task.assigneeId = null;
    if (!(await _saveField(TaskFCode.assignee))) {
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
      if (!(await _saveField(TaskFCode.assignee))) {
        task.assigneeId = oldValue;
      }
    }
  }

  /// даты

  Future _setStartDate(DateTime? _date) async {
    final oldValue = task.startDate;
    if (task.startDate != _date) {
      task.startDate = _date;
      if (!(await _saveField(TaskFCode.startDate))) {
        task.startDate = oldValue;
      }
    }
  }

  Future _setDueDate(DateTime? _date) async {
    final oldValue = task.dueDate;
    if (task.dueDate != _date) {
      task.dueDate = _date;
      if (!(await _saveField(TaskFCode.dueDate))) {
        task.dueDate = oldValue;
      }
    }
  }

  void _resetDate(TaskFCode code) {
    if (code == TaskFCode.startDate) {
      _setStartDate(null);
    } else if (code == TaskFCode.dueDate) {
      _setDueDate(null);
    }
  }

  Future selectDate(BuildContext context, TaskFCode code) async {
    final isStart = code == TaskFCode.startDate;

    final hasFutureStart = task.startDate != null && task.startDate!.isAfter(today);
    final selectedDate = isStart ? task.startDate : task.dueDate;

    final pastDate = today.subtract(year * 100);
    final futureDate = today.add(year * 100);

    final initialDate = selectedDate ?? (hasFutureStart ? task.startDate! : today);
    final firstDate = isStart ? pastDate : task.startDate ?? today;
    final lastDate = (isStart ? task.dueDate : null) ?? futureDate;

    // !! Нельзя давать менять способ ввода - поплывёт кнопка "Сбросить".
    // Если нужен ввод с клавиатуры, то нужно доработать позиционирование кнопки "Сбросить"
    // final entryMode = isWeb ? DatePickerEntryMode.input : DatePickerEntryMode.calendar;
    const entryMode = DatePickerEntryMode.calendarOnly;

    final date = await showDatePicker(
      context: context,
      initialEntryMode: entryMode,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      builder: (_, child) => LayoutBuilder(
        builder: (ctx, size) {
          final isPortrait = size.maxHeight > size.maxWidth;
          return Stack(
            children: [
              child!,
              if (selectedDate != null)
                Positioned(
                  left: size.maxWidth / 2 - (isPortrait ? 140 : 60),
                  top: size.maxHeight / 2 + (isPortrait ? 220 : 126),
                  child: MTButton(
                      middle: MediumText(loc.clear_action_title, color: warningColor, sizeScale: 0.9),
                      onTap: () {
                        Navigator.of(ctx).pop();
                        _resetDate(code);
                      }),
                ),
            ],
          );
        },
      ),
    );

    if (date != null) {
      if (isStart) {
        _setStartDate(date);
      } else {
        _setDueDate(date);
      }
    }
  }

  /// статусы

  Future<Task?> _setStatus(Task t, {int? statusId, bool? close}) async {
    if (t.canSetStatus) {
      t.statusId = statusId;
    }

    if (close != null) {
      t.closed = close;
      if (close) {
        t.closedDate = DateTime.now();
      }
    }

    return await taskUC.save(_ws, t);
  }

  Future<Task?> _setStatusTaskTree(
    Task _task, {
    int? statusId,
    bool? close,
    bool recursively = false,
  }) async {
    if (recursively) {
      // TODO: перенести на бэк?
      for (final t in _task.tasks.where((t) => t.closed != close)) {
        await _setStatus(t, statusId: statusId, close: close);
      }
    }
    return await _setStatus(_task, statusId: statusId, close: close);
  }

  Future selectStatus() async {
    final selectedStatusId = await showMTSelectDialog<Status>(
      task.statuses,
      task.statusId,
      loc.task_status_placeholder,
    );

    if (selectedStatusId != null) {
      await setStatus(task, statusId: selectedStatusId);
    }
  }

  Future<bool?> _closeDialog() async => await showMTAlertDialog(
        loc.close_dialog_recursive_title,
        description: loc.close_dialog_recursive_description,
        actions: [
          MTADialogAction(title: loc.close_w_subtasks, type: MTActionType.isWarning, result: true),
          MTADialogAction(title: loc.cancel, type: MTActionType.isDefault, result: false),
        ],
      );

  Future setStatus(Task _task, {int? statusId, bool? close}) async {
    if (statusId != null || close != null) {
      bool recursively = false;

      statusId ??= close == true ? _task.firstClosedStatusId : _task.firstOpenedStatusId;
      close ??= _task.statusForId(statusId)?.closed;

      if (close == true && _task.hasOpenedSubtasks) {
        recursively = await _closeDialog() == true;
        if (!recursively) {
          return;
        }
      }

      // TODO: сделать лоадер над строкой со статусом только

      loader.start();
      loader.setSaving();

      final editedTask = await _setStatusTaskTree(_task, statusId: statusId, close: close, recursively: recursively);
      await loader.stop();

      if (editedTask != null) {
        //TODO: может неожиданно для пользователя вываливаться в случае редактирования статуса закрытой задачи
        if (editedTask.closed && _task.id == task.id) {
          Navigator.of(rootKey.currentContext!).pop(editedTask);
        }
        mainController.refresh();
      }
    }
  }

  /// оценка

  Future _resetEstimate() async {
    final oldValue = task.estimate;
    task.estimate = null;
    if (!(await _saveField(TaskFCode.estimate))) {
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
      if (!(await _saveField(TaskFCode.estimate))) {
        task.estimate = oldValue;
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
      if (!(await _saveField(TaskFCode.parent))) {
        task.parent = sourceGoal;
      } else {
        sourceGoal.tasks.removeWhere((t) => t.id == task.id);
        destinationGoal.tasks.add(task);
        mainController.refresh();
      }
    }
  }
}
