// Copyright (c) 2022. Alexandr Moroz

import 'task.dart';

enum TaskState { overdue, risk, ok, noInfo }

extension TaskStats on Task {
  /// непосредственно сама задача
  Duration? get plannedPeriod => dueDate?.difference(createdOn);
  Duration get pastPeriod => DateTime.now().difference(createdOn);
  Duration? get overduePeriod => dueDate != null ? DateTime.now().difference(dueDate!) : null;

  double get _factSpeed => closedTasksCount / pastPeriod.inSeconds;

  DateTime? get etaDate =>
      _factSpeed > 0 && openedLeafTasksCount > 0 ? DateTime.now().add(Duration(seconds: (openedLeafTasksCount / _factSpeed).round())) : null;
  Duration? get etaRiskPeriod => dueDate != null ? etaDate?.difference(dueDate!) : null;
  bool get _hasOverdue => (overduePeriod?.inSeconds ?? 0) > 0;
  bool get _hasRisk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) > 0;
  bool get _isOk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) <= 0;

  bool get hasSubtasks => tasks.isNotEmpty;

  /// статистика по подзадачам
  Iterable<Task> get allTasks {
    final List<Task> res = [];
    for (Task t in tasks) {
      res.addAll(t.allTasks);
      res.add(t);
    }
    return res;
  }

  Iterable<Task> get _leafTasks => allTasks.where((t) => t.tasks.isEmpty);
  int get _leafTasksCount => _leafTasks.length;

  Iterable<Task> get _openedLeafTasks => _leafTasks.where((t) => !t.closed);
  int get openedLeafTasksCount => _openedLeafTasks.length;
  int get closedTasksCount => _leafTasksCount - openedLeafTasksCount;
  double get doneRatio => _leafTasksCount > 0 ? closedTasksCount / _leafTasksCount : 0;

  Iterable<Task> get _timeBoundOpenedTasks => allTasks.where((t) => !t.closed && t.dueDate != null);

  Iterable<Task> get _overdueTasks => _timeBoundOpenedTasks.where((t) => t._hasOverdue);
  int get overdueTasksCount => _overdueTasks.length;
  bool get hasOverdueTasks => overdueTasksCount > 0;
  Duration get tasksOverduePeriod {
    int totalSeconds = 0;
    _overdueTasks.forEach((t) => totalSeconds += t.overduePeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  Iterable<Task> get _riskyTasks => _timeBoundOpenedTasks.where((t) => t._hasRisk);
  int get riskyTasksCount => _riskyTasks.length;
  bool get hasRiskTasks => riskyTasksCount > 0;

  Duration get tasksRiskPeriod {
    int totalSeconds = 0;
    _riskyTasks.forEach((t) => totalSeconds += t.etaRiskPeriod?.inSeconds ?? 0);
    return Duration(seconds: totalSeconds);
  }

  Iterable<Task> get _noDueTasks => _openedLeafTasks.where((t) => t.dueDate == null);
  int get noDueTasksCount => _noDueTasks.length;
  bool get hasNoDueTasks => noDueTasksCount > 0;

  /// группы задач
  Iterable<Task> get _groups => allTasks.where((t) => t.tasks.isNotEmpty);
  Iterable<Task> get _openedGroups => _groups.where((t) => !t.closed);
  int get openedGroupsCount => _openedGroups.length;

  Iterable<Task> get _inactiveGroups => _openedGroups.where((t) => t.closedTasksCount == 0);
  int get inactiveGroupsCount => _inactiveGroups.length;
  bool get hasInactiveGroups => inactiveGroupsCount > 0;

  Iterable<Task> get _closableGroups => _openedGroups.where((t) => t.openedLeafTasksCount == 0 && t.closedTasksCount > 0);
  int get closableGroupsCount => _closableGroups.length;
  bool get hasClosableGroups => closableGroupsCount > 0;

  TaskState get state => dueDate != null && !closed
      ? (_hasOverdue
          ? TaskState.overdue
          : _hasRisk
              ? TaskState.risk
              : _isOk
                  ? TaskState.ok
                  : TaskState.noInfo)
      : TaskState.noInfo;
}
