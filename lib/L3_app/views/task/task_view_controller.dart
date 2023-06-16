// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/estimate_value.dart';
import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/status.dart';
import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../../L1_domain/entities_extensions/task_members.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_alert_dialog.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_field_data.dart';
import '../../components/mt_select_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/duration_presenter.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/task_view_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import '../../usecases/ws_ext_actions.dart';
import '../../views/_base/edit_controller.dart';
import '../tariff/tariff_select_view.dart';
import 'task_edit_controller.dart';
import 'task_edit_view.dart';
import 'widgets/task_description_dialog.dart';

part 'task_view_controller.g.dart';

enum TaskTabKey { overview, subtasks, details, team }

enum TaskFCode { title, description, startDate, dueDate, estimate, assignee, author }

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {
  TaskViewController(int _wsId, int? _taskId) {
    wsId = _wsId;
    taskId = _taskId;
    final task = mainController.taskForId(wsId, taskId);
    initState(fds: [
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
        noText: true,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.dueDate.index,
        label: loc.task_due_date_label,
        placeholder: loc.task_due_date_placeholder,
        noText: true,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.estimate.index,
        label: !task.isProject && task.isLeaf ? loc.task_estimate_label : loc.task_estimate_group_label,
        placeholder: loc.task_estimate_placeholder,
        noText: true,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.assignee.index,
        label: loc.task_assignee_label,
        placeholder: loc.task_assignee_placeholder,
        noText: true,
        needValidate: false,
      ),
      MTFieldData(
        TaskFCode.author.index,
        label: loc.task_author_title,
        placeholder: loc.task_author_title,
        noText: true,
        needValidate: false,
      ),
    ]);
  }
}

abstract class _TaskViewControllerBase extends EditController with Store {
  late final int wsId;
  late final int? taskId;

  Task get task => mainController.taskForId(wsId, taskId);
  Workspace get _ws => mainController.wsForId(wsId);
  bool get plCreate => task.isRoot ? _ws.plProjects : _ws.plTasks;

  @observable
  bool isNew = false;

  Future<bool> _saveField(TaskFCode code) async {
    bool saved = false;
    updateField(code.index, loading: true);
    try {
      final editedTask = await taskUC.save(task);
      saved = editedTask != null;
      if (saved) {
        _updateTaskParents(editedTask);
      }
    } catch (e) {
      loader.start();
    }
    updateField(code.index, loading: false);
    return saved;
  }

  /// описание

  Future editDescription() async {
    final tc = teController(TaskFCode.description.index);
    if (tc != null) {
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
  }

  /// назначенный

  Future resetAssignee() async {
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

  Future selectDate(TaskFCode code) async {
    final isStart = code == TaskFCode.startDate;

    final today = DateTime.now();
    final pastDate = today.subtract(year);

    final lastDate = (isStart ? task.dueDate : null) ?? today.add(year * 100);
    final initialDate = (isStart ? task.startDate : task.dueDate) ?? (today.isAfter(lastDate) ? lastDate : today);
    final firstDate = (isStart ? null : task.startDate) ?? (pastDate.isAfter(initialDate) ? initialDate : pastDate);

    final date = await showDatePicker(
      context: rootKey.currentContext!,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (date != null) {
      if (isStart) {
        _setStartDate(date);
      } else {
        _setDueDate(date);
      }
    }
  }

  void resetDate(TaskFCode code) {
    if (code == TaskFCode.startDate) {
      _setStartDate(null);
    } else if (code == TaskFCode.dueDate) {
      _setDueDate(null);
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

    return await taskUC.save(t);
  }

  Future<Task?> _setStatusTaskTree(
    Task _task, {
    int? statusId,
    bool? close,
    bool recursively = false,
  }) async {
    if (recursively) {
      for (final t in _task.allTasks.where((t) => t.closed != close)) {
        await _setStatus(t, statusId: statusId, close: close);
      }
    }
    return await _setStatus(_task, statusId: statusId, close: close);
  }

  Future selectStatus() async {
    final selectedStatusId = await showMTSelectDialog<Status>(
      _ws.statuses,
      task.statusId,
      loc.task_status_placeholder,
    );

    if (selectedStatusId != null) {
      await setStatus(task, statusId: selectedStatusId);
    }
  }

  Future setStatus(Task _task, {int? statusId, bool? close}) async {
    if (statusId != null || close != null) {
      bool recursively = false;

      statusId ??= close == true ? _ws.firstClosedStatusId : _ws.firstOpenedStatusId;
      close ??= _ws.statusForId(statusId)?.closed;

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
        _updateTaskParents(editedTask);
      }
    }
  }

  /// оценка

  Future resetEstimate() async {
    final oldValue = task.estimate;
    task.estimate = null;
    if (!(await _saveField(TaskFCode.estimate))) {
      task.estimate = oldValue;
    }
  }

  Future selectEstimate() async {
    final selectedEstimateId = await showMTSelectDialog<EstimateValue>(
      _ws.estimateValues,
      _ws.estimateValueForValue(task.estimate)?.id,
      loc.task_estimate_placeholder,
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
    return task.isRoot
        ? []
        : [
            if (task.hasOverviewPane) TaskTabKey.overview,
            if (task.hasSubtasks) TaskTabKey.subtasks,
            if (task.hasTeamPane) TaskTabKey.team,
            TaskTabKey.details,
          ];
  }

  @observable
  TaskTabKey? _tabKey;
  @action
  void selectTab(TaskTabKey? tk) => _tabKey = tk;

  @computed
  TaskTabKey get tabKey => (tabKeys.contains(_tabKey) ? _tabKey : null) ?? (tabKeys.isNotEmpty ? tabKeys.first : TaskTabKey.subtasks);

  /// связь с источником импорта

  MTADialogAction<bool> _go2SourceDialogAction() => MTADialogAction(
        type: MTActionType.isDefault,
        onTap: () => launchUrlString(task.taskSource!.urlString),
        result: false,
        child: task.taskSource!.go2SourceTitle(),
      );

  Future<bool?> _unlinkDialog() async => await showMTAlertDialog(
        rootKey.currentContext!,
        title: loc.task_unlink_dialog_title,
        description: loc.task_unlink_dialog_description,
        actions: [
          MTADialogAction(
            title: loc.task_unlink_action_title,
            type: MTActionType.isWarning,
            result: true,
            icon: const UnlinkIcon(),
          ),
          _go2SourceDialogAction(),
        ],
      );

  Future<bool?> _unwatchDialog() async => await showMTAlertDialog(
        rootKey.currentContext!,
        title: loc.task_unwatch_dialog_title,
        description: loc.task_unwatch_dialog_description,
        actions: [
          MTADialogAction(
            title: loc.task_unwatch_action_title,
            type: MTActionType.isDanger,
            result: true,
            icon: const EyeIcon(open: false, color: dangerColor, size: P * 1.4),
          ),
          _go2SourceDialogAction(),
        ],
      );

  Future<bool?> _closeDialog() async => await showMTAlertDialog(
        rootKey.currentContext!,
        title: loc.close_dialog_recursive_title,
        description: loc.close_dialog_recursive_description,
        actions: [
          MTADialogAction(title: loc.close_w_subtasks, type: MTActionType.isWarning, result: true),
          MTADialogAction(title: loc.cancel, type: MTActionType.isDefault, result: false),
        ],
      );

  void _updateTaskParents(Task task) {
    task.updateParents();
    mainController.updateRootTask();
  }

  void _popDeleted(Task task) {
    final context = rootKey.currentContext!;
    Navigator.of(context).pop();
    if (task.parent?.isRoot == true && task.parent?.tasks.length == 1 && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  Future addSubtask() async {
    if (plCreate) {
      final newTaskResult = await editTaskDialog(TaskEditController(wsId, parent: task));

      if (newTaskResult != null) {
        final newTask = newTaskResult.task;
        task.tasks.add(newTask);
        _updateTaskParents(newTask);
        if (newTaskResult.proceed == true) {
          if (task.isProject || task.isRoot) {
            await mainController.showTask(wsId, newTask.id);
          } else {
            await addSubtask();
          }
        }
        selectTab(TaskTabKey.subtasks);
      }
    } else {
      await changeTariff(
        mainController.wsForId(wsId),
        reason: task.isRoot ? loc.tariff_change_limit_projects_reason_title : loc.tariff_change_limit_tasks_reason_title,
      );
    }
  }

  Future edit() async {
    final editTaskResult = await editTaskDialog(TaskEditController(wsId, task: task, parent: task.parent!));
    if (editTaskResult != null) {
      final editedTask = editTaskResult.task;
      if (editedTask.deleted) {
        _popDeleted(editedTask);
      }
      _updateTaskParents(editedTask);
    }
  }

  Future unlink() async {
    if (task.canUnlink) {
      if (await _unlinkDialog() == true) {
        loader.start();
        loader.setUnlinking();
        try {
          await importUC.unlinkTaskSources(task.wsId, task.id!, task.allTss());
          task.unlinkTaskTree();
          mainController.updateRootTask();
        } catch (_) {}
        await loader.stop();
      }
    } else {
      await changeTariff(task.ws, reason: loc.tariff_change_limit_unlink_reason_title);
    }
  }

  Future unwatch() async {
    if (await _unwatchDialog() == true) {
      loader.start();
      loader.setUnwatch();
      final deletedTask = await taskUC.delete(task);
      await loader.stop();
      if (deletedTask.deleted) {
        _popDeleted(deletedTask);
        _updateTaskParents(deletedTask);
      }
    }
  }

  Future taskAction(TaskActionType? actionType) async {
    switch (actionType) {
      case TaskActionType.add:
        await addSubtask();
        break;
      case TaskActionType.edit:
        await edit();
        break;
      case TaskActionType.close:
        await setStatus(task, close: true);
        break;
      case TaskActionType.reopen:
        await setStatus(task, close: false);
        break;
      case TaskActionType.go2source:
        await launchUrlString(task.taskSource!.urlString);
        break;
      case TaskActionType.unlink:
        await unlink();
        break;
      case TaskActionType.unwatch:
        await unwatch();
        break;
      default:
    }
  }
}
