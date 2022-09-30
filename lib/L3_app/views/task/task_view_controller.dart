// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_actions.dart';
import '../../../L1_domain/entities/task_ext_level.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../../L1_domain/usecases/task_comparators.dart';
import '../../components/icons.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/task_filter_presenter.dart';
import '../../presenters/task_source_presenter.dart';
import '../../presenters/task_state_presenter.dart';
import '../_base/base_controller.dart';
import 'task_edit_view.dart';

part 'task_view_controller.g.dart';

enum TaskTabKey { overview, subtasks, details }

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {
  TaskViewController(int? _taskID) {
    taskID = _taskID;
  }
}

abstract class _TaskViewControllerBase extends BaseController with Store {
  int? taskID;

  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

  @computed
  Task get task => mainController.taskForId(taskID);

  /// вкладки

  @computed
  bool get _hasDescription => task.description.isNotEmpty;
  @computed
  bool get _hasAuthor => task.author != null;
  @computed
  bool get _hasOverview => task.showState || task.showTimeChart;
  @computed
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

  /// фильтр и сортировка
  @computed
  Iterable<Task> get _sortedTasks {
    final tasks = task.tasks;
    tasks.sort(sortByDateAsc);
    return tasks;
  }

  @computed
  Iterable<Task> get _sortedOpenedTasks {
    final tasks = task.openedSubtasks.toList();
    tasks.sort(sortByDateAsc);
    return tasks;
  }

  @observable
  TaskFilter? _tasksFilter;

  @computed
  TaskFilter get tasksFilter => _tasksFilter ?? (task.hasOpenedSubtasks ? TaskFilter.opened : TaskFilter.all);

  @action
  void setFilter(TaskFilter? _filter) => _tasksFilter = _filter;

  @computed
  List<TaskFilter> get taskFilterKeys {
    final keys = <TaskFilter>[];
    if (task.hasOpenedSubtasks && task.openedSubtasksCount < task.tasks.length) {
      keys.add(TaskFilter.opened);
    }
    keys.add(TaskFilter.all);
    return keys;
  }

  @computed
  bool get hasFilters => taskFilterKeys.length > 1;

  Map<TaskFilter, Iterable<Task>> get _taskFilters => {
        TaskFilter.opened: _sortedOpenedTasks,
        TaskFilter.all: _sortedTasks,
      };

  @computed
  Iterable<Task> get filteredTasks => _taskFilters[tasksFilter] ?? [];

  /// связь с источником импорта

  //TODO: похоже, не используется этот метод вообще сейчас
  Future<bool> _checkUnlinked(BuildContext context) async {
    bool unlinked = !task.hasLink;
    if (!unlinked) {
      unlinked = await unlink(context);
    }
    return unlinked;
  }

  MTDialogAction<bool?> _go2SourceDialogAction(BuildContext context) => MTDialogAction(
        type: MTActionType.isDefault,
        onTap: () => launchUrl(task.taskSource!.uri),
        result: false,
        child: task.taskSource!.go2SourceTitle(context),
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
            icon: unlinkIcon(context),
          ),
          _go2SourceDialogAction(context),
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
            icon: unwatchIcon(context),
          ),
          _go2SourceDialogAction(context),
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

  Future<bool?> _reopenDialog(BuildContext context) async => await showMTDialog<bool?>(
        context,
        title: loc.reopen_dialog_recursive_title,
        description: loc.reopen_dialog_recursive_description,
        actions: [
          MTDialogAction(title: loc.reopen_w_subtasks, type: MTActionType.isWarning, result: true),
          MTDialogAction(title: loc.reopen_selected_only, type: MTActionType.isDefault, result: false),
        ],
      );

  /// роутер

  Future<Task?> _setClosedTaskTree(Task _task, bool _isClose, bool _recursively) async {
    if (_recursively) {
      for (final t in _task.allTasks.where((t) => t.closed != _isClose)) {
        t.closed = _isClose;
        await tasksUC.save(t);
      }
    }
    _task.closed = _isClose;
    return await tasksUC.save(_task);
  }

  Future setClosed(BuildContext context, bool isClose) async {
    bool cancel = false;
    bool recursively = false;

    if (isClose) {
      if (task.hasOpenedSubtasks) {
        recursively = await _closeDialog(context) == true;
        cancel = !recursively;
      }
    } else if (task.hasClosedSubtasks) {
      final res = await _reopenDialog(context);
      cancel = res == null;
      recursively = res == true;
    }

    if (cancel) {
      return;
    }

    startLoading();
    final editedTask = await _setClosedTaskTree(task, isClose, recursively);
    stopLoading();
    if (editedTask != null) {
      if (editedTask.closed) {
        Navigator.of(context).pop(editedTask);
      }
      editedTask.updateParents();
      mainController.touchRootTask();
    }
  }

  Future addSubtask(BuildContext context) async {
    if (await _checkUnlinked(context)) {
      startLoading();
      final newTask = await editTaskDialog(context, parent: task);
      stopLoading();
      if (newTask != null) {
        task.tasks.add(newTask);
        newTask.updateParents();
        mainController.touchRootTask();
      }
    }
  }

  Future edit(BuildContext context) async {
    if (await _checkUnlinked(context)) {
      final editedTask = await editTaskDialog(context, parent: task.parent!, task: task);
      if (editedTask != null) {
        if (editedTask.deleted) {
          Navigator.of(context).pop();
        }
        editedTask.updateParents();
        mainController.touchRootTask();
      }
    }
  }

  Future<bool> unlink(BuildContext context) async {
    bool res = false;
    if (await _unlinkDialog(context) == true) {
      startLoading();
      res = await importUC.updateTaskSources(task.unlinkTaskTree());
      mainController.touchRootTask();
      stopLoading();
    }
    return res;
  }

  Future unwatch(BuildContext context) async {
    if (await _unwatchDialog(context) == true) {
      startLoading();
      final deletedTask = await tasksUC.delete(t: task);
      stopLoading();
      if (deletedTask != null && deletedTask.deleted) {
        Navigator.of(context).pop();
        deletedTask.updateParents();
        mainController.touchRootTask();
      }
    }
  }

  Future<void> taskAction(TaskActionType? actionType, BuildContext context) async {
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
      case TaskActionType.import:
        await importController.importTasks(context);
        break;
      case TaskActionType.go2source:
        await launchUrl(task.taskSource!.uri);
        break;
      case TaskActionType.unlink:
        await unlink(context);
        break;
      case TaskActionType.unwatch:
        await unwatch(context);
        break;
      case null:
    }
  }
}
