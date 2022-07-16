// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../task/task_edit_view.dart';
import '../task/task_view.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {}

abstract class _TaskViewControllerBase extends BaseController with Store {
  /// история переходов и текущая выбранная задача

  @observable
  ObservableList<Task> navStackTasks = ObservableList();

  @computed
  int? get _selectedTaskId => navStackTasks.isNotEmpty ? navStackTasks.last.id : null;

  @computed
  Task? get selectedTask => rootTask.allTasks.firstWhereOrNull((t) => t.id == _selectedTaskId);

  @action
  void pushTask(Task _task) {
    navStackTasks.add(_task);
  }

  @action
  void popTask() {
    if (navStackTasks.isNotEmpty) {
      navStackTasks.removeLast();
    }
  }

  /// рутовый объект

  @observable
  Task rootTask = Task(
    id: -1,
    title: 'root',
    description: '',
    closed: false,
    tasks: [],
    dueDate: null,
    createdOn: DateTime.now(),
    trackerId: null,
    parentId: null,
    updatedOn: DateTime.now(),
  );

  @action
  void _sortTasks() {
    rootTask.tasks.sort((g1, g2) => g1.title.compareTo(g2.title));
  }

  @action
  Future fetchData() async {
    startLoading();
    clearData();
    final List<Task> tasks = [];
    for (Workspace ws in mainController.workspaces) {
      tasks.addAll(ws.rootTasks);
    }
    rootTask = rootTask.copyWithList(tasks);
    tasksFilterController.setDefaultFilter();
    _sortTasks();
    stopLoading();
  }

  @action
  void clearData() => rootTask = rootTask.copyWithList([]);

  /// Список подзадач

  // универсальный способ получить подзадачи первого уровня для цели и для выбранной задачи
  @computed
  List<Task> get subtasks {
    final _tasks = selectedTask?.tasks ?? [];
    _tasks.sort((t1, t2) => t1.title.compareTo(t2.title));
    return _tasks;
  }

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

  @action
  void _updateTask(Task _task, Task _parent) {
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
    final parent = rootTask.allTasks.firstWhereOrNull((t) => t.id == _task.parentId);
    if (parent != null) {
      _updateParents(parent);
      _updateTask(_task, parent);
    } else {
      _updateTask(_task, rootTask);
    }
  }

  /// роутер

  Future showEW(BuildContext context, Task _ew) async {
    pushTask(_ew);
    await Navigator.of(context).pushNamed(TaskView.routeName);
    popTask();
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
      } else {
        _updateTask(editedTask, selectedTask!);
      }
      _updateParents(editedTask);
    }
  }
}
