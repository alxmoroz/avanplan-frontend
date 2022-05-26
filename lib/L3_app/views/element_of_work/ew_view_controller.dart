// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../task/task_edit_view.dart';
import 'ew_view.dart';

part 'ew_view_controller.g.dart';

class EWViewController extends _EWViewControllerBase with _$EWViewController {}

abstract class _EWViewControllerBase extends BaseController with Store {
  Goal get selectedGoal => goalController.selectedGoal!;

  /// история переходов и текущая выбранная задача

  @observable
  ObservableList<Task> navStackTasks = ObservableList();

  @computed
  int? get _selectedTaskId => navStackTasks.isNotEmpty ? navStackTasks.last.id : null;

  @computed
  Task? get selectedTask => selectedGoal.tasks.firstWhereOrNull((t) => t.id == _selectedTaskId);

  @computed
  bool get isGoal => selectedTask == null;

  @computed
  ElementOfWork? get selectedEW => isGoal ? selectedGoal : selectedTask;

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

  /// Список подзадач

  // универсальный способ получить подзадачи первого уровня для цели и для выбранной задачи
  @computed
  List<Task> get subtasks {
    // TODO: может просто selectedEW.tasks?
    final _tasks = selectedGoal.tasks.where((t) => t.parentId == _selectedTaskId).toList();
    _tasks.sort((t1, t2) => t1.title.compareTo(t2.title));
    return _tasks;
  }

  /// редактирование подзадач
  @action
  void _addTask(Task _task) {
    selectedGoal.tasks.add(_task);
    if (!isGoal) {
      selectedTask!.tasks.add(_task);
    }
  }

  @action
  void _deleteTask(Task _task, List<Task>? _subtasks) {
    for (Task t in _subtasks ?? []) {
      _deleteTask(t, _task.tasks);
    }
    selectedGoal.tasks.remove(selectedGoal.tasks.firstWhereOrNull((t) => t.id == _task.id));
  }

  @action
  void _updateTask(Task _task, ElementOfWork _parent) {
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
    final parent = selectedGoal.tasks.firstWhereOrNull((t) => t.id == _task.parentId);
    if (parent != null) {
      _updateParents(parent);
      _updateTask(_task, parent);
    } else {
      _updateTask(_task, selectedGoal);
      goalController.updateGoalInList(selectedGoal);
    }
  }

  /// роутер
  Future showTask(BuildContext context, Task _task) async {
    pushTask(_task);
    await Navigator.of(context).pushNamed(EWView.routeName);
    popTask();
  }

  Future addEW(BuildContext context) async {
    await addTask(context);
  }

  Future addTask(BuildContext context) async {
    final newTask = await showEditTaskDialog(context);
    if (newTask != null) {
      _addTask(newTask);
      _updateParents(newTask);
    }
  }

  Future editEW(BuildContext context) async {
    if (isGoal) {
      await goalController.editGoal(context, selectedGoal);
    } else {
      await editTask(context);
    }
  }

  Future editTask(BuildContext context) async {
    final editedTask = await showEditTaskDialog(context, selectedTask);
    if (editedTask != null) {
      if (editedTask.deleted) {
        _deleteTask(editedTask, null);
        Navigator.of(context).pop();
      } else {
        _updateTask(editedTask, selectedGoal);
      }
      _updateParents(editedTask);
    }
  }
}
