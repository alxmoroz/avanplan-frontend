// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/smartable.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import 'task_edit_view.dart';
import 'task_view.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {}

abstract class _TaskViewControllerBase extends BaseController with Store {
  Goal get goal => goalController.selectedGoal!;

  /// Список подзадач

  // универсальный способ получить подзадачи первого уровня для цели и для выбранной задачи
  @computed
  List<Task> get subtasks => goal.tasks.where((t) => t.parentId == task?.id).toList();

  void sortTasks() {
    goal.tasks.sort((t1, t2) => t1.title.compareTo(t2.title));
  }

  void _addTask(Task _task) {
    goal.tasks.add(_task);
    if (!isGoal) {
      task!.tasks.add(_task);
    }
  }

  void _deleteTask(Task _task, List<Task>? _subtasks) {
    for (Task t in _subtasks ?? []) {
      _deleteTask(t, _task.tasks);
    }
    goal.tasks.remove(goal.tasks.firstWhereOrNull((t) => t.id == _task.id));
  }

  void _updateTask(Task _task, Smartable _parent) {
    final index = _parent.tasks.indexWhere((t) => t.id == _task.id);
    if (index >= 0) {
      if (_task.deleted) {
        _parent.tasks.removeAt(index);
      } else {
        _parent.tasks[index] = _task.copy();
      }
    }
  }

  void _updateParents(Task _task) {
    final parent = goal.tasks.firstWhereOrNull((t) => t.id == _task.parentId);
    if (parent != null) {
      _updateParents(parent);
      _updateTask(_task, parent);
    } else {
      _updateTask(_task, goal);
      sortTasks();
      mainController.updateGoalInList(goal);
    }
  }

  /// история переходов и текущая выбранная задача

  @observable
  ObservableList<Task> navStackTasks = ObservableList();

  @computed
  int? get selectedTaskId => navStackTasks.isNotEmpty ? navStackTasks.last.id : null;

  @computed
  Task? get task => goal.tasks.firstWhereOrNull((t) => t.id == selectedTaskId);

  @computed
  bool get isGoal => task == null;

  @action
  void pushTask(Task? _task) {
    if (_task != null) {
      navStackTasks.add(_task);
    }
  }

  @action
  void popTask() {
    if (navStackTasks.isNotEmpty) {
      navStackTasks.removeLast();
    }
  }

  /// роутер
  @action
  Future showTask(BuildContext context, Task? _task) async {
    pushTask(_task);
    await Navigator.of(context).pushNamed(TaskView.routeName);
    popTask();
  }

  @action
  Future addTask(BuildContext context) async {
    final newTask = await showEditTaskDialog(context);
    if (newTask != null) {
      _addTask(newTask);
      _updateParents(newTask);
    }
  }

  @action
  Future editTask(BuildContext context) async {
    final editedTask = await showEditTaskDialog(context, task);
    if (editedTask != null) {
      if (editedTask.deleted) {
        _deleteTask(editedTask, null);
        Navigator.of(context).pop();
      } else {
        _updateTask(editedTask, goal);
      }
      _updateParents(editedTask);
    }
  }
}
