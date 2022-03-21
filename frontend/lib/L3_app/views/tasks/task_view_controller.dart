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
  bool get isRootTask => selectedTask == null;

  @computed
  List<Task> get _srcSubtasks => isRootTask ? mainController.selectedGoal!.tasks : selectedTask!.tasks;

  @computed
  List<Task> get subtasks {
    final tasks = isRootTask ? _srcSubtasks.where((t) => t.parentId == null).toList() : _srcSubtasks;
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
  void updateTasklistWith(Task _task) {
    final siblings = navStackTasks.length > 1 ? navStackTasks[navStackTasks.length - 2].tasks : mainController.selectedGoal!.tasks;
    final index = siblings.indexWhere((t) => t.id == _task.id);
    if (index >= 0) {
      if (_task.deleted) {
        siblings.removeAt(index);
      } else {
        siblings.setAll(index, [_task]);
      }
    }
    //TODO: костылик
    navStackTasks = ObservableList.of(navStackTasks);
  }

  /// роутер

  Future showTask(BuildContext context, Task _task) async {
    pushTask(_task);
    await Navigator.of(context).pushNamed(TaskView.routeName);
    popTask();
  }

  Future addTask(BuildContext context) async {
    final newTask = await showEditTaskDialog(context);
    if (newTask != null) {
      _srcSubtasks.add(newTask);
      await showTask(context, newTask);
    }
  }

  Future editTask(BuildContext context) async {
    final editedTask = await showEditTaskDialog(context, selectedTask);
    if (editedTask != null) {
      updateTasklistWith(editedTask);

      if (editedTask.deleted) {
        Navigator.of(context).pop();
      } else {
        //
      }
    }
  }
}
