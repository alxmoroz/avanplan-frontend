// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import 'task_edit_view.dart';
import 'task_view.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {}

abstract class _TaskViewControllerBase extends BaseController with Store {
  Goal get goal => mainController.selectedGoal!;

  /// Список подзадач
  @observable
  ObservableList<Task> goalTasks = ObservableList();

  @action
  void fetchTasks() {
    goalTasks = ObservableList.of(goal.tasks);
    _sortTasks();
  }

  @computed
  List<Task> get subtasks => goalTasks.where((t) => t.parentId == task?.id).toList();

  @action
  void _sortTasks() {
    goalTasks.sort((t1, t2) => t1.title.compareTo(t2.title));
  }

  @action
  void updateTaskInList(Task? task) {
    if (task != null) {
      final index = goalTasks.indexWhere((t) => t.id == task.id);
      if (index >= 0) {
        if (task.deleted) {
          goalTasks.remove(task);
        } else {
          goalTasks[index] = task;
        }
      } else {
        goalTasks.add(task);
      }
      _sortTasks();
      goal.tasks = List.of(goalTasks);
    }
  }

  /// история переходов и текущая выбранная задача

  @observable
  ObservableList<Task> navStackTasks = ObservableList();

  @computed
  int? get selectedTaskId => navStackTasks.isNotEmpty ? navStackTasks.last.id : null;

  @computed
  Task? get task => goalTasks.firstWhereOrNull((t) => t.id == selectedTaskId);

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

  Future showTask(BuildContext context, Task? _task) async {
    pushTask(_task);
    await Navigator.of(context).pushNamed(TaskView.routeName);
    popTask();
  }

  Future addTask(BuildContext context) async {
    final newTask = await showEditTaskDialog(context);
    if (newTask != null) {
      updateTaskInList(newTask);
      await showTask(context, newTask);
    }
  }

  Future editTask(BuildContext context) async {
    final editedTask = await showEditTaskDialog(context, task);
    if (editedTask != null) {
      updateTaskInList(editedTask);
      if (editedTask.deleted) {
        Navigator.of(context).pop();
      }
    }
  }
}
