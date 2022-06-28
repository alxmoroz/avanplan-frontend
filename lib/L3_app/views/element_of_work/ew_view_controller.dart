// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/element_of_work.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../goal/goal_edit_view.dart';
import '../task/task_edit_view.dart';
import 'ew_view.dart';

part 'ew_view_controller.g.dart';

class EWViewController extends _EWViewControllerBase with _$EWViewController {}

abstract class _EWViewControllerBase extends BaseController with Store {
  /// история переходов и текущая выбранная задача

  @observable
  ObservableList<ElementOfWork> navStackTasks = ObservableList();

  @computed
  int? get _selectedTaskId => navStackTasks.isNotEmpty ? navStackTasks.last.id : null;

  @computed
  ElementOfWork? get selectedTask => selectedGoal?.tasks.firstWhereOrNull((t) => t.id == _selectedTaskId);

  @computed
  bool get isGoal => selectedTask == null;

  //TODO: закрыть доступ снаружи к  selectedGoal : selectedTask
  @computed
  ElementOfWork? get selectedEW => isGoal ? selectedGoal : selectedTask;

  @action
  void pushTask(ElementOfWork _task) {
    navStackTasks.add(_task);
  }

  @action
  void popTask() {
    if (navStackTasks.isNotEmpty) {
      navStackTasks.removeLast();
    }
  }

  /// цели
  /// цели - рутовый объект

  // TODO: здесь можно заменить на Smartable для подзадач и использовать в дашборде задач и цели. И перенести в контроллер Smartable

  @observable
  ObservableList<ElementOfWork> goals = ObservableList();

  @action
  void _sortGoals() {
    goals.sort((g1, g2) => g1.title.compareTo(g2.title));
  }

  @action
  void updateGoalInList(ElementOfWork? _goal) {
    if (_goal != null) {
      final index = goals.indexWhere((g) => g.id == _goal.id);
      if (index >= 0) {
        if (_goal.deleted) {
          goals.remove(_goal);
        } else {
          goals[index] = _goal.copy();
        }
      } else {
        goals.add(_goal);
      }
      _sortGoals();
    }
  }

  void updateFilter(ElementOfWork ew) {
    if (!ew.deleted && !ew.closed && ewFilterController.filteredEW.firstWhereOrNull((e) => e.id == ew.id) == null ||
        !ewFilterController.ewFilterKeys.contains(ewFilterController.ewFilter)) {
      ewFilterController.setDefaultFilter();
    }
  }

  @action
  Future fetchData() async {
    startLoading();
    clearData();
    for (Workspace ws in mainController.workspaces) {
      goals.addAll(ws.goals);
    }
    ewFilterController.setDefaultFilter();
    _sortGoals();
    stopLoading();
  }

  @action
  void clearData() => goals.clear();

  /// выбранная цель

  @observable
  int? selectedGoalId;

  @action
  void selectGoal(ElementOfWork? _goal) => selectedGoalId = _goal?.id;

  @computed
  ElementOfWork? get selectedGoal => goals.firstWhereOrNull((g) => g.id == selectedGoalId);

  /// Список подзадач

  // универсальный способ получить подзадачи первого уровня для цели и для выбранной задачи
  @computed
  List<ElementOfWork> get subtasks {
    // TODO: может просто selectedEW.tasks?
    final _tasks = selectedGoal?.tasks.where((t) => t.parentId == _selectedTaskId).toList() ?? [];
    _tasks.sort((t1, t2) => t1.title.compareTo(t2.title));
    return _tasks;
  }

  /// редактирование подзадач
  @action
  void _addTask(ElementOfWork _task) {
    selectedGoal!.tasks.add(_task);
    if (!isGoal) {
      selectedTask!.tasks.add(_task);
    }
  }

  @action
  void _deleteTask(ElementOfWork _task, List<ElementOfWork>? _subtasks) {
    for (ElementOfWork t in _subtasks ?? []) {
      _deleteTask(t, _task.tasks);
    }
    selectedGoal!.tasks.remove(selectedGoal!.tasks.firstWhereOrNull((t) => t.id == _task.id));
  }

  @action
  void _updateTask(ElementOfWork _task, ElementOfWork _parent) {
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
  void _updateParents(ElementOfWork _task) {
    final parent = selectedGoal!.tasks.firstWhereOrNull((t) => t.id == _task.parentId);
    if (parent != null) {
      _updateParents(parent);
      _updateTask(_task, parent);
    } else {
      _updateTask(_task, selectedGoal!);
      updateGoalInList(selectedGoal);
    }
  }

  /// роутер
  Future showTask(BuildContext context, ElementOfWork _task) async {
    pushTask(_task);
    await Navigator.of(context).pushNamed(EWView.routeName);
    popTask();
  }

  Future showGoal(BuildContext context, ElementOfWork goal) async {
    selectGoal(goal);
    await Navigator.of(context).pushNamed(EWView.routeName);
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
      await editGoal(context, selectedGoal);
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
        _updateTask(editedTask, selectedGoal!);
      }
      _updateParents(editedTask);
    }
  }

  Future addGoal(BuildContext context) async => editGoal(context, null);

  Future editGoal(BuildContext context, ElementOfWork? selectedGoal) async {
    selectGoal(selectedGoal);
    final goal = await showEditGoalDialog(context);
    if (goal != null) {
      updateGoalInList(goal);
      updateFilter(goal);
      if (goal.deleted || goal.closed) {
        Navigator.of(context).pop();
      }
    }
  }
}
