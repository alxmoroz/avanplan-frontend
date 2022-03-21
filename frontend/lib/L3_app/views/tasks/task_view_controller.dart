// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import 'task_edit_view.dart';
import 'task_view.dart';

part 'task_view_controller.g.dart';

class TaskViewController extends _TaskViewControllerBase with _$TaskViewController {}

abstract class _TaskViewControllerBase extends BaseController with Store {
  @observable
  ObservableList<Task> navStackTasks = ObservableList();

  @computed
  Task? get selectedTask => navStackTasks.isNotEmpty ? navStackTasks.last : null;

  @computed
  bool get isRoot => selectedTask == null;

  @computed
  List<Task> get _srcTasks => isRoot ? mainController.selectedGoal!.tasks : selectedTask!.tasks;

  @computed
  List<Task> get tasks {
    final tasks = isRoot ? _srcTasks.where((t) => t.parentId == null).toList() : _srcTasks;
    tasks.sort((t1, t2) => t1.title.compareTo(t2.title));
    return tasks;
  }

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

  @action
  void updateParentWith(Task _task) {
    final index = _srcTasks.indexWhere((t) => t.id == _task.id);
    if (index >= 0) {
      if (_task.deleted) {
        _srcTasks.removeAt(index);
      } else {
        _srcTasks.setAll(index, [_task]);
      }
    } else {
      _srcTasks.add(_task);
    }
  }

  /// роутер

  Future showTask(BuildContext context, Task _task) async {
    pushTask(_task);
    await Navigator.of(context).pushNamed(TaskView.routeName);
    popTask();
  }

  Future addTask(BuildContext context) async {
    taskEditController.selectTask(null);
    final newTask = await showEditTaskDialog(context);
    if (newTask != null) {
      updateParentWith(newTask);
      await showTask(context, newTask);
    }
  }
}
