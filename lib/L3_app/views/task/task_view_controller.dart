// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_source.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../../presenters/task_stats_presenter.dart';
import '../_base/base_controller.dart';
import '../task/task_edit_view.dart';
import '../task/task_view.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {}

abstract class _TaskViewControllerBase extends BaseController with Store {
  /// рутовый объект
  @observable
  Task rootTask = Task(
    title: '',
    parent: null,
    tasks: [],
    description: '',
    closed: false,
    createdOn: DateTime.now(),
    updatedOn: DateTime.now(),
  );

  /// история переходов и текущая выбранная задача
  @observable
  ObservableList<Task> navStack = ObservableList();

  @computed
  int? get _selectedTaskId => navStack.isNotEmpty ? navStack.last.id : null;

  @computed
  Task get selectedTask => rootTask.allTasks.firstWhereOrNull((t) => t.id == _selectedTaskId) ?? rootTask;

  @computed
  bool get isWorkspace => selectedTask.level == TaskLevel.workspace;

  /// доступные действия
  @computed
  bool get canAdd => !(selectedTask.hasLink || selectedTask.closed);

  @computed
  bool get canEdit => !(selectedTask.hasLink || isWorkspace);

  @computed
  bool get canImport => isWorkspace;

  @computed
  bool get canRefresh => isWorkspace;

  @action
  void _pushTask(Task _task) => navStack.add(_task);

  @action
  void _popTask() {
    if (navStack.isNotEmpty) {
      navStack.removeLast();
    }
  }

  @override
  bool get isLoading => super.isLoading || mainController.isLoading;

  @action
  Future fetchData() async {
    final tasks = <Task>[];
    for (Workspace ws in mainController.workspaces) {
      if (ws.id != null) {
        tasks.addAll(await tasksUC.getRoots(ws.id!));
      }
    }
    tasks.forEach((t) => t.parent = rootTask);
    rootTask.tasks = tasks;

    rootTask = rootTask.copy();
    // TODO: чтобы сохранять положение в навигации внутри приложения, нужно отправлять набор хлебных крошек на сервер в профиль пользователя
    // TODO: а также нужно проверять корректность пути этого при загрузке, чтобы не было зацикливаний, обрывов и т.п.
    navStack.clear();
  }

  @action
  void clearData() {
    navStack.clear();
    rootTask.tasks = [];
  }

  void _updateParentTask(Task _task) {
    final _parent = _task.parent;
    if (_parent != null) {
      final index = _parent.tasks.indexWhere((t) => t.id == _task.id);
      if (index >= 0) {
        if (_task.deleted) {
          _parent.tasks.removeAt(index);
        } else {
          //TODO: проверить необходимость в copy
          _parent.tasks[index] = _task.copy();
        }
      }
      rootTask = rootTask.copy();
    }
  }

  void _updateParents(Task _task) {
    final _parent = _task.parent;
    if (_parent != null) {
      _updateParents(_parent);
    }
    _updateParentTask(_task);
  }

  /// роутер
  Future showTask(BuildContext context, Task _t) async {
    _pushTask(_t);
    await Navigator.of(context).pushNamed(TaskView.routeName);
    _popTask();
  }

  Future addTask(BuildContext context) async {
    final newTask = await showEditTaskDialog(context);
    if (newTask != null) {
      selectedTask.tasks.add(newTask);
      _updateParents(newTask);
    }
  }

  Future editTask(BuildContext context) async {
    final editedTask = await showEditTaskDialog(context, selectedTask);
    if (editedTask != null) {
      if (editedTask.deleted) {
        Navigator.of(context).pop();
      }
      _updateParents(editedTask);
    }
  }

  Future setTaskClosed(BuildContext context, Task task, bool closed) async {
    task.closed = closed;
    final editedTask = await tasksUC.save(task);
    if (editedTask != null) {
      if (editedTask.closed) {
        Navigator.of(context).pop(editedTask);
      }
      _updateParents(editedTask);
    }
  }

  Iterable<TaskSource> _unlinkTaskTree(Task t) {
    final tss = <TaskSource>[];
    for (Task subtask in t.tasks) {
      tss.addAll(_unlinkTaskTree(subtask));
    }

    if (t.hasLink) {
      t.taskSource?.keepConnection = false;
      tss.add(t.taskSource!);
    }
    return tss;
  }

  Future unlink(BuildContext context) async {
    final confirm = await showMTDialog<int?>(
      context,
      title: loc.task_unlink_dialog_title,
      description: loc.task_unlink_dialog_description,
      actions: [
        MTDialogAction(title: loc.task_unlink_dialog_action_unlink_title, isDestructive: true, result: 1),
        MTDialogAction(title: loc.task_unlink_dialog_action_copy_title, isDefault: true, result: 2),
        MTDialogAction(title: loc.common_no, isDefault: true, result: 0),
      ],
    );
    if (confirm != null && confirm > 0) {
      startLoading();
      if (confirm == 1) {
        final unlinkedTask = await tasksUC.delete(t: selectedTask);
        if (unlinkedTask != null) {
          _updateParents(unlinkedTask);
          Navigator.of(context).pop();
        }
      } else if (confirm == 2) {
        await importUC.updateTaskSources(_unlinkTaskTree(selectedTask));
      }
      stopLoading();
    }
  }
}
