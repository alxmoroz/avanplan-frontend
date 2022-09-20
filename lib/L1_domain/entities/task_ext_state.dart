// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'task.dart';
import 'task_ext_level.dart';

enum TaskState { overdue, risk, closable, noDueDate, noSubtasks, noProgress, ok, noInfo }

extension TaskStats on Task {
  /// непосредственно сама задача
  bool get hasDueDate => dueDate != null;
  DateTime get _startDate => createdOn ?? DateTime.now();
  Duration get _pastPeriod => DateTime.now().difference(_startDate);
  Duration get overduePeriod => hasDueDate ? DateTime.now().difference(dueDate!) : const Duration(seconds: 0);

  double get _factSpeed => _closedLeafTasksCount / _pastPeriod.inSeconds;
  DateTime? get etaDate => (hasDueDate && _factSpeed > 0 && openedLeafTasksCount > 0)
      ? DateTime.now().add(Duration(seconds: (openedLeafTasksCount / _factSpeed).round()))
      : null;
  bool get hasEtaDate => etaDate != null;

  Duration get riskPeriod => hasEtaDate ? etaDate!.difference(dueDate!) : const Duration(seconds: 0);

  bool get hasOverdue => overduePeriod.inSeconds > 0;
  bool get hasRisk => riskPeriod.inSeconds > 0;
  bool get _isOk => hasEtaDate && riskPeriod.inSeconds < 1;

  Iterable<DateTime> get _sortedDates {
    final dates = [
      if (hasDueDate) dueDate!,
      if (hasEtaDate) etaDate!,
      DateTime.now(),
    ];
    if (dates.length > 1) {
      dates.sort((d1, d2) => d1.compareTo(d2));
    }
    return dates;
  }

  /// диаграмма сроков
  DateTime get _minDate => _sortedDates.first;
  DateTime get _maxDate => _sortedDates.last;

  int get _maxDateSeconds => _maxDate.difference(_minDate).inSeconds;
  double dateRatio(DateTime dt) => _maxDateSeconds > 0 ? (dt.difference(_minDate).inSeconds / _maxDateSeconds) : 1;

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
  int get _closedSubtasksCount => tasks.length - openedSubtasksCount;

  bool get isClosable => !closed && hasSubtasks && !hasOpenedSubtasks;

  Iterable<Task> get _leafTasks => allTasks.where((t) => !t.hasSubtasks);
  int get _leafTasksCount => _leafTasks.length;
  Iterable<Task> get _openedLeafTasks => _leafTasks.where((t) => !t.closed);
  int get openedLeafTasksCount => _openedLeafTasks.length;

  int get _closedLeafTasksCount => _leafTasksCount - openedLeafTasksCount;

  double get doneRatio => (hasDueDate && _leafTasksCount > 0) ? _closedLeafTasksCount / _leafTasksCount : 0;

  /// опоздание
  Duration get totalOverduePeriod => Duration(
        seconds: openedSubtasks.map((t) => t.totalOverduePeriod.inSeconds).fold(
              overduePeriod.inSeconds,
              (s, res) => max(s, res),
            ),
      );
  Iterable<Task> get overdueSubtasks => openedSubtasks.where((t) => t.state == TaskState.overdue);

  /// риск
  Duration get totalRiskPeriod => Duration(
        seconds: openedSubtasks.map((t) => t.totalRiskPeriod.inSeconds).fold(
              riskPeriod.inSeconds,
              (s, res) => s + res,
            ),
      );
  Iterable<Task> get riskySubtasks => tasks.where((t) => t.state == TaskState.risk);

  /// цели (для дашборда проекта рекомендации)
  // TODO: нужно сделать универсальным. Речь про подзадачи первого уровня
  Iterable<Task> get _goals => allTasks.where((t) => t.isGoal);

  Iterable<Task> get _openedGoals => _goals.where((t) => !t.closed);
  int get openedGoalsCount => _openedGoals.length;

  Iterable<Task> get _noDueGoals => _openedGoals.where((t) => !t.hasDueDate);
  int get noDueGoalsCount => _noDueGoals.length;
  bool get hasNoDueGoals => noDueGoalsCount > 0;

  Iterable<Task> get _emptyGoals => _openedGoals.where((t) => !t.hasSubtasks);
  int get emptyGoalsCount => _emptyGoals.length;
  bool get hasEmptyGoals => emptyGoalsCount > 0;

  Iterable<Task> get _inactiveGoals => _openedGoals.where((t) => t.hasSubtasks && t._closedSubtasksCount == 0);
  int get inactiveGoalsCount => _inactiveGoals.length;
  bool get hasInactiveGoals => inactiveGoalsCount > 0;

  /// можно закрыть
  Iterable<Task> get _closableGroups => allTasks.where((t) => t.isClosable);
  int get closableGroupsCount => _closableGroups.length;
  bool get hasClosableGroups => closableGroupsCount > 0;

  /// подзадачи в порядке
  bool get _hasOkSubtasks => openedSubtasks.isNotEmpty && openedSubtasks.every((t) => t.state == TaskState.ok);

  /// интегральный статус
  TaskState get state => !closed
      ? (totalOverduePeriod.inSeconds > 0
          ? TaskState.overdue
          : totalRiskPeriod.inSeconds > 0
              ? TaskState.risk
              : isClosable
                  ? TaskState.closable
                  : (!hasDueDate && (!isWorkspace && !isProject && hasSubtasks))
                      ? TaskState.noDueDate
                      : ((isGoal || isProject) && !hasSubtasks)
                          ? TaskState.noSubtasks
                          : (isGoal && _closedSubtasksCount == 0)
                              ? TaskState.noProgress
                              : _isOk || ((isWorkspace || isProject) && _hasOkSubtasks)
                                  ? TaskState.ok
                                  : TaskState.noInfo)
      : TaskState.noInfo;

  bool get showState => !closed && (hasSubtasks || isGoal || state != TaskState.noInfo);
}
