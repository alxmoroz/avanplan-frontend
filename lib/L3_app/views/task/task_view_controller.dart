// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

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
import '../../components/mt_button.dart';
import '../../components/mt_dialog.dart';
import '../../components/mt_field_data.dart';
import '../../components/mt_select_dialog.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';
import '../../presenters/duration_presenter.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/task_level_presenter.dart';
import '../../presenters/task_view_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import '../../usecases/ws_ext_actions.dart';
import '../../views/_base/edit_controller.dart';
import '../tariff/tariff_select_view.dart';
import 'widgets/task_description_dialog.dart';

part 'task_view_controller.g.dart';

// TODO: уменьшить размер файла, разнести по отдельным контроллерам. Например, отдельно редактирование и просмотр

enum TaskTabKey { overview, subtasks, details, team }

enum TaskFCode { title, description, startDate, dueDate, estimate, assignee, author }

enum TasksFilter { my }

class TaskParams {
  TaskParams(this.wsId, {this.taskId, this.isNew = false, this.filters});
  final int wsId;
  final int? taskId;
  final bool isNew;
  final Set<TasksFilter>? filters;
}

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {
  TaskViewController([TaskParams? tp]) {
    wsId = tp?.wsId ?? -1;
    taskId = tp?.taskId;
    isNew = tp?.isNew ?? false;
    filters = tp?.filters ?? {};

    final task = mainController.taskForId(wsId, taskId);
    initState(fds: [
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
  late final bool isNew;
  late final Set<TasksFilter> filters;

  bool get isMyTasks => filters.contains(TasksFilter.my);

  Task get task => mainController.taskForId(wsId, taskId);
  Workspace get ws => mainController.wsForId(wsId);
  bool get plCreate => task.isRoot ? ws.plProjects : ws.plTasks;

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

  /// название

  String get titlePlaceholder => task.parent!.newSubtaskTitle;

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
    _titleEditTimer = Timer(const Duration(milliseconds: 500), () async => await _setTitle(str));
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

    final pastDate = today.subtract(year);
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
      ws.statuses,
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

      statusId ??= close == true ? ws.firstClosedStatusId : ws.firstOpenedStatusId;
      close ??= ws.statusForId(statusId)?.closed;

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

  Future _resetEstimate() async {
    final oldValue = task.estimate;
    task.estimate = null;
    if (!(await _saveField(TaskFCode.estimate))) {
      task.estimate = oldValue;
    }
  }

  Future selectEstimate() async {
    final selectedEstimateId = await showMTSelectDialog<EstimateValue>(
      ws.estimateValues,
      ws.estimateValueForValue(task.estimate)?.id,
      loc.task_estimate_placeholder,
      onReset: _resetEstimate,
    );

    if (selectedEstimateId != null) {
      final oldValue = task.estimate;
      task.estimate = ws.estimateValueForId(selectedEstimateId)?.value;
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
        loc.task_unlink_dialog_title,
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

  Future<bool?> _closeDialog() async => await showMTAlertDialog(
        loc.close_dialog_recursive_title,
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
      loader.start();
      loader.setSaving();
      final newTask = await taskUC.save(Task(
        title: task.newSubtaskTitle,
        statusId: (task.isRoot || task.isProject) ? null : ws.statuses.firstOrNull?.id,
        closed: false,
        parent: task,
        tasks: [],
        wsId: wsId,
        members: [],
      ));
      loader.stop();
      if (newTask != null) {
        task.tasks.add(newTask);
        _updateTaskParents(newTask);
        selectTab(TaskTabKey.subtasks);
        await mainController.showTask(TaskParams(wsId, taskId: newTask.id, isNew: true));
      }
    } else {
      await changeTariff(
        mainController.wsForId(wsId),
        reason: task.isRoot ? loc.tariff_change_limit_projects_reason_title : loc.tariff_change_limit_tasks_reason_title,
      );
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

  Future delete() async {
    final confirm = await showMTAlertDialog(
      task.deleteDialogTitle,
      description: '${loc.task_delete_dialog_description}\n${loc.delete_dialog_description}',
      actions: [
        MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
      ],
      simple: true,
    );
    if (confirm == true) {
      loader.start();
      loader.setDeleting();
      final deletedTask = await taskUC.delete(task);
      if (deletedTask.deleted) {
        _popDeleted(deletedTask);
        _updateTaskParents(deletedTask);
      }
      await loader.stop(300);
    }
  }

  Future taskAction(TaskActionType? actionType) async {
    switch (actionType) {
      case TaskActionType.close:
        await setStatus(task, close: true);
        break;
      case TaskActionType.reopen:
        await setStatus(task, close: false);
        break;
      case TaskActionType.unlink:
        await unlink();
        break;
      case TaskActionType.delete:
        await delete();
        break;
      default:
    }
  }
}
