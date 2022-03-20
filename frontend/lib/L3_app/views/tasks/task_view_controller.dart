// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import 'task_edit_view.dart';
import 'task_view.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {}

abstract class _TaskViewControllerBase extends BaseController with Store {
  @override
  void initState({List<TFAnnotation>? tfaList}) {
    super.initState(tfaList: tfaList);
    updateSubtasks();
  }

  @observable
  ObservableList<Task> subtasks = ObservableList();

  @observable
  ObservableList<Task> navStackTasks = ObservableList();

  @computed
  Task? get selectedTask => navStackTasks.isNotEmpty ? navStackTasks.last : null;

  @action
  void updateSubtasks() {
    Iterable<Task> _tasks = [];
    if (selectedTask != null) {
      _tasks = selectedTask!.tasks;
    } else {
      _tasks = mainController.selectedGoal!.tasks.where((t) => t.parentId == null);
    }
    subtasks = ObservableList.of(_tasks);
    _sortSubtasks();
  }

  @action
  void pushTask(Task _task) {
    navStackTasks.add(_task);
    updateSubtasks();
  }

  @action
  void popTask() {
    if (navStackTasks.isNotEmpty) {
      navStackTasks.removeLast();
    }
    updateSubtasks();
  }

  @action
  void updateSubTask(Task _task) {
    final index = subtasks.indexWhere((t) => t.id == _task.id);
    if (index >= 0) {
      if (_task.deleted) {
        subtasks.removeAt(index);
      } else {
        subtasks.setAll(index, [_task]);
      }
    } else {
      subtasks.add(_task);
    }
    _sortSubtasks();
  }

  @action
  void _sortSubtasks() {
    subtasks.sort((t1, t2) => t1.title.compareTo(t2.title));
  }

  /// роутер

  Future showTask(BuildContext context, Task _task) async {
    pushTask(_task);
    await Navigator.of(context).pushNamed(TaskView.routeName, arguments: _task.id);
    popTask();
  }

  Future addTask(BuildContext context) async {
    taskEditController.selectTask(null);
    final newTask = await showEditTaskDialog(context);
    if (newTask != null) {
      updateSubTask(newTask);
      await showTask(context, newTask);
    }
  }
}
