// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/usecases/task_ext_level.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/state_presenter.dart';
import '../../presenters/task_filter_presenter.dart';
import 'task_edit_view.dart';
import 'task_ext_actions.dart';

part 'task_view_controller.g.dart';

enum TaskTabKey { overview, subtasks, details }

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {
  TaskViewController(int? _taskID) {
    taskID = _taskID;
  }
}

abstract class _TaskViewControllerBase with Store {
  int? taskID;

  Task get task => mainController.taskForId(taskID);

  /// вкладки
  bool get _hasDescription => task.description.isNotEmpty;
  bool get _hasAuthor => task.author != null;
  bool get _hasOverview => task.showState || task.showTimeChart || task.showVelocityVolumeCharts;
  bool get _hasDetails => _hasDescription || _hasAuthor;

  @computed
  Iterable<TaskTabKey> get tabKeys {
    return task.isWorkspace
        ? []
        : [
            if (_hasOverview) TaskTabKey.overview,
            if (task.hasSubtasks) TaskTabKey.subtasks,
            if (_hasDetails) TaskTabKey.details,
          ];
  }

  @observable
  TaskTabKey? _tabKey;
  @action
  void selectTab(TaskTabKey? tk) => _tabKey = tk;

  @computed
  TaskTabKey get tabKey => (tabKeys.contains(_tabKey) ? _tabKey : null) ?? (tabKeys.isNotEmpty ? tabKeys.first : TaskTabKey.subtasks);

  /// фильтры и сортировка
  @observable
  bool? _showGroupTitles;

  @computed
  bool get showGroupTitles => _showGroupTitles ?? task.subtaskGroups.length > 1 && task.tasks.length > 4;

  @computed
  bool get canEditTask => authController.canEditWS(mainController.rolesForWS(task.workspaceId));

  /// связь с источником импорта

  // TODO: похоже, не используется этот метод вообще сейчас
  Future<bool> _checkUnlinked(BuildContext context) async {
    bool unlinked = !task.hasLink;
    if (!unlinked) {
      unlinked = await unlink(context);
    }
    return unlinked;
  }

  MTDialogAction<bool?> _go2SourceDialogAction() => MTDialogAction(
        type: MTActionType.isDefault,
        onTap: () => launchUrlString(task.taskSource!.urlString),
        result: false,
        child: task.taskSource!.go2SourceTitle(),
      );

  Future<bool?> _unlinkDialog(BuildContext context) async => await showMTDialog<bool?>(
        context,
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

  Future<bool?> _unwatchDialog(BuildContext context) async => await showMTDialog<bool?>(
        context,
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

  Future<bool?> _closeDialog(BuildContext context) async => await showMTDialog<bool?>(
        context,
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

  void _popDeleted(BuildContext context, Task task) {
    Navigator.of(context).pop();
    if (task.parent?.isWorkspace == true && task.parent?.tasks.length == 1 && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  /// роутер

  Future<Task?> _setClosedTask(Task t, bool close) async {
    t.closed = close;
    if (close) {
      t.closedDate = DateTime.now();
    }
    return await tasksUC.save(t);
  }

  Future<Task?> _setClosedTaskTree(Task _task, bool close, bool _recursively) async {
    if (_recursively) {
      for (final t in _task.allTasks.where((t) => t.closed != close)) {
        await _setClosedTask(t, close);
      }
    }
    return await _setClosedTask(_task, close);
  }

  Future setClosed(BuildContext context, bool close) async {
    bool recursively = false;

    if (close) {
      if (task.hasOpenedSubtasks) {
        recursively = await _closeDialog(context) == true;
        if (!recursively) {
          return;
        }
      }
    } else {
      recursively = false;
    }

    loaderController.start();
    loaderController.setClosing(close);
    final editedTask = await _setClosedTaskTree(task, close, recursively);
    await loaderController.stop();

    if (editedTask != null) {
      if (editedTask.closed) {
        Navigator.of(context).pop(editedTask);
      }
      _updateTaskParents(editedTask);
    }
  }

  Future addSubtask(BuildContext context) async {
    if (await _checkUnlinked(context)) {
      final newTaskResult = await editTaskDialog(context, parent: task);
      if (newTaskResult != null) {
        final newTask = newTaskResult.task;
        task.tasks.add(newTask);
        _updateTaskParents(newTask);
        if (newTaskResult.proceed == true) {
          if (task.isProject || task.isWorkspace) {
            await mainController.showTask(context, newTask.id);
          } else {
            await addSubtask(context);
          }
        }
        selectTab(TaskTabKey.subtasks);
      }
    }
  }

  Future edit(BuildContext context) async {
    if (await _checkUnlinked(context)) {
      final editTaskResult = await editTaskDialog(context, parent: task.parent!, task: task);
      if (editTaskResult != null) {
        final editedTask = editTaskResult.task;
        if (editedTask.deleted) {
          _popDeleted(context, editedTask);
        }
        _updateTaskParents(editedTask);
      }
    }
  }

  Future<bool> unlink(BuildContext context) async {
    bool res = false;
    if (await _unlinkDialog(context) == true) {
      loaderController.start();
      loaderController.setUnlinking();
      try {
        await importUC.updateTaskSources(task.unlinkTaskTree());
        mainController.updateRootTask();
        res = true;
      } catch (_) {}
      await loaderController.stop();
    }
    return res;
  }

  Future unwatch(BuildContext context) async {
    if (await _unwatchDialog(context) == true) {
      loaderController.start();
      loaderController.setUnwatch();
      final deletedTask = await tasksUC.delete(t: task);
      await loaderController.stop();
      if (deletedTask.deleted) {
        _popDeleted(context, deletedTask);
        _updateTaskParents(deletedTask);
      }
    }
  }

  Future taskAction(TaskActionType? actionType, BuildContext context) async {
    switch (actionType) {
      case TaskActionType.add:
        await addSubtask(context);
        break;
      case TaskActionType.edit:
        await edit(context);
        break;
      case TaskActionType.close:
        await setClosed(context, true);
        break;
      case TaskActionType.reopen:
        await setClosed(context, false);
        break;
      case TaskActionType.import_gitlab:
        await importController.importTasks(context, sType: referencesController.stGitlab);
        break;
      case TaskActionType.import_jira:
        await importController.importTasks(context, sType: referencesController.stJira);
        break;
      case TaskActionType.import_redmine:
        await importController.importTasks(context, sType: referencesController.stRedmine);
        break;
      case TaskActionType.go2source:
        await launchUrlString(task.taskSource!.urlString);
        break;
      case TaskActionType.unlink:
        await unlink(context);
        break;
      case TaskActionType.unwatch:
        await unwatch(context);
        break;
      default:
    }
  }
}
