// Copyright (c) 2022. Alexandr Moroz

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

  /// история переходов и текущая выбранная задача

  @observable
  ObservableList<Task> navStackTasks = ObservableList();

  @computed
  Task? get selectedTask => navStackTasks.isNotEmpty ? navStackTasks.last : null;

  @computed
  bool get isRootTask => selectedTask == null;

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

  /// Список подзадач

  @computed
  List<Task> get subtasks => goal.tasks.where((t) => t.parentId == selectedTask?.id).toList();

  @action
  void _sortTasks() {
    goal.tasks.sort((t1, t2) => t1.title.compareTo(t2.title));
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
      _sortTasks();
      await showTask(context, newTask);
    }
  }

  Future editTask(BuildContext context) async {
    final editedTask = await showEditTaskDialog(context, selectedTask);
    if (editedTask != null) {
      _sortTasks();
      if (editedTask.deleted) {
        Navigator.of(context).pop();
      }
    }
  }
}
