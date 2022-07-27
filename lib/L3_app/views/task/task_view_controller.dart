// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_stats.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../task/task_edit_view.dart';
import '../task/task_view.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {}

abstract class _TaskViewControllerBase extends BaseController with Store {
  /// рутовый объект
  @observable
  Task rootTask = Task(
    id: -1,
    title: '',
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
  Task? get selectedTask => rootTask.allTasks.firstWhereOrNull((t) => t.id == _selectedTaskId) ?? rootTask;

  @computed
  bool get isVirtualRoot => selectedTask == rootTask;

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
    clearData();
    for (Workspace ws in mainController.workspaces) {
      final rt = await tasksUC.getRoots(ws.id);
      rootTask.tasks.addAll(rt);
    }
    _touchRoot();
  }

  /// костыль для обновления selectedTask по сути...
  @action
  void _touchRoot() => rootTask = rootTask.copy();

  @action
  void clearData() {
    navStack.clear();
    rootTask.tasks.clear();
    rootTask = rootTask.copy();
  }

  /// Список подзадач
  /// редактирование подзадач
  @action
  void _addTask(Task _task) {
    selectedTask!.tasks.add(_task);
  }

  @action
  void _deleteTask(Task _task, List<Task>? _subtasks) {
    for (Task t in _subtasks ?? []) {
      _deleteTask(t, _task.tasks);
    }
    selectedTask!.tasks.remove(selectedTask!.tasks.firstWhereOrNull((t) => t.id == _task.id));
  }

  Task _parentTask(Task _task) => rootTask.allTasks.firstWhereOrNull((t) => t.id == _task.parentId) ?? rootTask;

  @action
  void _updateTask(Task _task) {
    final _parent = _parentTask(_task);
    final index = _parent.tasks.indexWhere((t) => t.id == _task.id);
    if (index >= 0) {
      if (_task.deleted) {
        _parent.tasks.removeAt(index);
      } else {
        _parent.tasks[index] = _task.copy();
      }
    }
  }

  @action
  void _updateParents(Task _task) {
    final _parent = _parentTask(_task);
    if (_parent != rootTask) {
      _updateParents(_parent);
    }
    _updateTask(_task);

    _touchRoot();
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
      _addTask(newTask);
      _updateParents(newTask);
    }
  }

  Future editTask(BuildContext context) async {
    final editedTask = await showEditTaskDialog(context, selectedTask);
    if (editedTask != null) {
      if (editedTask.deleted) {
        _deleteTask(editedTask, null);
        Navigator.of(context).pop();
      }
      _updateParents(editedTask);
    }
  }
}
