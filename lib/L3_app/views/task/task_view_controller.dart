// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/source_presenter.dart';
import '../../presenters/state_presenter.dart';
import '../../presenters/task_filter_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import '../import/import_view.dart';
import 'task_edit_view.dart';

part 'task_view_controller.g.dart';

enum TaskTabKey { overview, subtasks, details, team }

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
  bool get _hasAuthor => task.authorId != null;
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
            if (task.canMembersRead && (task.members.isNotEmpty || task.canEditMembers)) TaskTabKey.team,
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

  /// связь с источником импорта

  // TODO: похоже, не используется этот метод вообще сейчас
  Future<bool> _checkUnlinked() async {
    bool unlinked = !task.hasLink;
    if (!unlinked) {
      unlinked = await unlink();
    }
    return unlinked;
  }

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
    return await taskUC.save(t);
  }

  Future<Task?> _setClosedTaskTree(Task _task, bool close, bool _recursively) async {
    if (_recursively) {
      for (final t in _task.allTasks.where((t) => t.closed != close)) {
        await _setClosedTask(t, close);
      }
    }
    return await _setClosedTask(_task, close);
  }

  Future setClosed(bool close) async {
    bool recursively = false;
    if (close) {
      if (task.hasOpenedSubtasks) {
        recursively = await _closeDialog() == true;
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
        Navigator.of(rootKey.currentContext!).pop(editedTask);
      }
      _updateTaskParents(editedTask);
    }
  }

  Future addSubtask() async {
    if (await _checkUnlinked()) {
      final newTaskResult = await editTaskDialog(parent: task);

      if (newTaskResult != null) {
        final newTask = newTaskResult.task;
        task.tasks.add(newTask);
        _updateTaskParents(newTask);
        if (newTaskResult.proceed == true) {
          if (task.isProject || task.isWorkspace) {
            await mainController.showTask(newTask.id);
          } else {
            await addSubtask();
          }
        }
        selectTab(TaskTabKey.subtasks);
      }
    }
  }

  Future edit() async {
    if (await _checkUnlinked()) {
      final editTaskResult = await editTaskDialog(parent: task.parent!, task: task);
      if (editTaskResult != null) {
        final editedTask = editTaskResult.task;
        if (editedTask.deleted) {
          _popDeleted(editedTask);
        }
        _updateTaskParents(editedTask);
      }
    }
  }

  Future unlink() async {
    if (await _unlinkDialog() == true) {
      loaderController.start();
      loaderController.setUnlinking();
      try {
        await importUC.unlinkTaskSources(task.wsId, task.id!, task.allTss());
        task.unlinkTaskTree();
        mainController.updateRootTask();
      } catch (_) {}
      await loaderController.stop();
    }
  }

  Future unwatch() async {
    if (await _unwatchDialog() == true) {
      loaderController.start();
      loaderController.setUnwatch();
      final deletedTask = await taskUC.delete(task);
      await loaderController.stop();
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
        await setClosed(true);
        break;
      case TaskActionType.reopen:
        await setClosed(false);
        break;
      case TaskActionType.import_gitlab:
        await importTasks(sType: refsController.stGitlab);
        break;
      case TaskActionType.import_jira:
        await importTasks(sType: refsController.stJira);
        break;
      case TaskActionType.import_redmine:
        await importTasks(sType: refsController.stRedmine);
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
