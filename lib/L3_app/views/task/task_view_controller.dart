// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../L1_domain/entities_extensions/ws_ext.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/task_view_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import '../../usecases/ws_ext_actions.dart';
import '../tariff/tariff_select_view.dart';
import 'task_edit_controller.dart';
import 'task_edit_view.dart';
import 'widgets/status_select_dialog.dart';

part 'task_view_controller.g.dart';

enum TaskTabKey { overview, subtasks, details, team }

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {
  TaskViewController(int _wsId, int? _taskId) {
    wsId = _wsId;
    taskId = _taskId;
  }
}

abstract class _TaskViewControllerBase with Store {
  late final int wsId;
  late final int? taskId;

  Task get task => mainController.taskForId(wsId, taskId);
  Workspace get _ws => mainController.wsForId(wsId);
  bool get plCreate => task.isRoot ? _ws.plProjects : _ws.plTasks;

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

  MTDialogAction<bool> _go2SourceDialogAction() => MTDialogAction(
        type: MTActionType.isDefault,
        onTap: () => launchUrlString(task.taskSource!.urlString),
        result: false,
        child: task.taskSource!.go2SourceTitle(),
      );

  Future<bool?> _unlinkDialog() async => await showMTDialog(
        rootKey.currentContext!,
        title: loc.task_unlink_dialog_title,
        description: loc.task_unlink_dialog_description,
        actions: [
          MTDialogAction(
            title: loc.task_unlink_action_title,
            type: MTActionType.isWarning,
            result: true,
            icon: const UnlinkIcon(),
          ),
          _go2SourceDialogAction(),
        ],
      );

  Future<bool?> _unwatchDialog() async => await showMTDialog(
        rootKey.currentContext!,
        title: loc.task_unwatch_dialog_title,
        description: loc.task_unwatch_dialog_description,
        actions: [
          MTDialogAction(
            title: loc.task_unwatch_action_title,
            type: MTActionType.isDanger,
            result: true,
            icon: const EyeIcon(open: false, color: dangerColor, size: P * 1.4),
          ),
          _go2SourceDialogAction(),
        ],
      );

  Future<bool?> _closeDialog() async => await showMTDialog(
        rootKey.currentContext!,
        title: loc.close_dialog_recursive_title,
        description: loc.close_dialog_recursive_description,
        actions: [
          MTDialogAction(title: loc.close_w_subtasks, type: MTActionType.isWarning, result: true),
          MTDialogAction(title: loc.cancel, type: MTActionType.isDefault, result: false),
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
    final selectedStatusId = await statusSelectDialog(_ws, task.statusId);

    if (selectedStatusId != null) {
      await setStatus(statusId: selectedStatusId);
    }
  }

  Future setStatus({int? statusId, bool? close}) async {
    if (statusId != null || close != null) {
      bool recursively = false;

      statusId ??= close == true ? _ws.firstClosedStatusId : _ws.firstOpenedStatusId;
      close ??= _ws.statusForId(statusId)?.closed;

      if (close == true && task.hasOpenedSubtasks) {
        recursively = await _closeDialog() == true;
        if (!recursively) {
          return;
        }
      }

      loader.start();
      loader.setSaving();

      final editedTask = await _setStatusTaskTree(task, statusId: statusId, close: close, recursively: recursively);
      await loader.stop();

      if (editedTask != null) {
        //TODO: может неожиданно для пользователя вываливаться в случае редактирования статуса закрытой задачи
        if (editedTask.closed) {
          Navigator.of(rootKey.currentContext!).pop(editedTask);
        }
        _updateTaskParents(editedTask);
      }
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
        await setStatus(close: true);
        break;
      case TaskActionType.reopen:
        await setStatus(close: false);
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
