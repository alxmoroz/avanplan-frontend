// Copyright (c) 2022. Alexandr Moroz

import 'task.dart';
import 'task_ext_level.dart';

enum TaskState { overdue, risk, ok, noInfo }

extension TaskStats on Task {
  /// непосредственно сама задача
  bool get hasDueDate => dueDate != null;
  DateTime get _startDate => createdOn ?? DateTime.now();
  Duration get _pastPeriod => DateTime.now().difference(_startDate);
  Duration? get _overduePeriod => hasDueDate ? DateTime.now().difference(dueDate!) : null;

  double get _factSpeed => closedTasksCount / _pastPeriod.inSeconds;
  DateTime? get etaDate => (hasDueDate && _factSpeed > 0 && openedLeafTasksCount > 0)
      ? DateTime.now().add(Duration(seconds: (openedLeafTasksCount / _factSpeed).round()))
      : null;
  bool get hasEtaDate => etaDate != null;

  Duration? get _etaRiskPeriod => hasDueDate ? etaDate?.difference(dueDate!) : null;

  bool get _hasOverdue => hasDueDate && (_overduePeriod?.inSeconds ?? 0) > 0;
  bool get _hasRisk => hasDueDate && hasEtaDate && (_etaRiskPeriod?.inSeconds ?? 0) > 0;
  bool get _isOk => hasDueDate && hasEtaDate && (_etaRiskPeriod?.inSeconds ?? 0) <= 0;

  bool get hasSubtasks => tasks.isNotEmpty;
  bool get hasLink => taskSource?.keepConnection == true;

  /// статистика по подзадачам
  Iterable<Task> get allTasks {
    final res = <Task>[];
    for (Task t in tasks) {
      res.addAll(t.allTasks);
      res.add(t);
    }
    return res;
  }

  Iterable<Task> get openedSubtasks => tasks.where((t) => !t.closed);
  int get openedSubtasksCount => openedSubtasks.length;
  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;

  bool get isClosable => !closed && hasSubtasks && !hasOpenedSubtasks;

  Iterable<Task> get _leafTasks => allTasks.where((t) => !t.hasSubtasks);
  int get _leafTasksCount => _leafTasks.length;
  Iterable<Task> get _openedLeafTasks => _leafTasks.where((t) => !t.closed);
  int get openedLeafTasksCount => _openedLeafTasks.length;

  int get closedTasksCount => _leafTasksCount - openedLeafTasksCount;

  double get doneRatio => (hasDueDate && _leafTasksCount > 0) ? closedTasksCount / _leafTasksCount : 0;

  Iterable<Task> get _timeBoundOpenedTasks => allTasks.where((t) => !t.closed && t.hasDueDate);

  Iterable<Task> get _overdueTasks => _timeBoundOpenedTasks.where((t) => t._hasOverdue);
  int get overdueTasksCount => _overdueTasks.length;
  bool get hasOverdueTasks => overdueTasksCount > 0;
  Duration get totalOverduePeriod {
    int totalSeconds = _overduePeriod?.inSeconds ?? 0;
    _overdueTasks.forEach((t) => totalSeconds += t._overduePeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  Iterable<Task> get _riskyTasks => _timeBoundOpenedTasks.where((t) => t._hasRisk);
  int get riskyTasksCount => _riskyTasks.length;
  bool get hasRiskTasks => riskyTasksCount > 0;
  Duration get totalRiskPeriod {
    int totalSeconds = _etaRiskPeriod?.inSeconds ?? 0;
    _riskyTasks.forEach((t) => totalSeconds += t._etaRiskPeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  /// цели
  Iterable<Task> get _goals => allTasks.where((t) => t.isGoal);

  Iterable<Task> get _openedGoals => _goals.where((t) => !t.closed);
  int get openedGoalsCount => _openedGoals.length;

  Iterable<Task> get _noDueGoals => _openedGoals.where((t) => !t.hasDueDate);
  int get noDueGoalsCount => _noDueGoals.length;
  bool get hasNoDueGoals => noDueGoalsCount > 0;

  Iterable<Task> get _emptyGoals => _openedGoals.where((t) => !t.hasSubtasks);
  int get emptyGoalsCount => _emptyGoals.length;
  bool get hasEmptyGoals => noDueGoalsCount > 0;

  Iterable<Task> get _inactiveGoals => _openedGoals.where((t) => t.closedTasksCount == 0);
  int get inactiveGoalsCount => _inactiveGoals.length;
  bool get hasInactiveGoals => inactiveGoalsCount > 0;

  /// можно закрыть
  Iterable<Task> get _closableGroups => allTasks.where((t) => t.isClosable);
  int get closableGroupsCount => _closableGroups.length;
  bool get hasClosableGroups => closableGroupsCount > 0;

  /// интегральный статус
  TaskState get state => !closed
      ? (_hasOverdue || hasOverdueTasks
          ? TaskState.overdue
          : _hasRisk || hasRiskTasks
              ? TaskState.risk
              : _isOk
                  ? TaskState.ok
                  : TaskState.noInfo)
      : TaskState.noInfo;
}
