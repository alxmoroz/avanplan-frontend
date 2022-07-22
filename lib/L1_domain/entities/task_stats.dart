// Copyright (c) 2022. Alexandr Moroz

import 'task.dart';

enum OverallState { overdue, risk, ok, noInfo }

extension TaskStats on Task {
  Duration? get plannedPeriod => dueDate?.difference(createdOn);
  Duration get pastPeriod => DateTime.now().difference(createdOn);
  Duration? get overduePeriod => dueDate != null ? DateTime.now().difference(dueDate!) : null;

  Iterable<Task> get allTasks {
    final List<Task> res = [];
    for (Task t in tasks) {
      res.addAll(t.allTasks);
      res.add(t);
    }
    return res;
  }

  Iterable<Task> get leafTasks => allTasks.where((t) => t.allTasks.isEmpty);
  int get leafTasksCount => leafTasks.length;
  int get closedTasksCount => leafTasks.where((t) => t.closed).length;
  int get leftTasksCount => leafTasksCount - closedTasksCount;
  double get doneRatio => leafTasksCount > 0 ? closedTasksCount / leafTasksCount : 0;

  double get _factSpeed => closedTasksCount / pastPeriod.inSeconds;

  DateTime? get etaDate => _factSpeed > 0 && leftTasksCount > 0 ? DateTime.now().add(Duration(seconds: (leftTasksCount / _factSpeed).round())) : null;
  Duration? get etaRiskPeriod => dueDate != null ? etaDate?.difference(dueDate!) : null;

  bool get _hasOverdue => (overduePeriod?.inSeconds ?? 0) > 0;
  bool get _hasRisk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) > 0;
  bool get _isOk => etaDate != null && (etaRiskPeriod?.inSeconds ?? 0) <= 0;

  OverallState get overallState => dueDate != null && !closed
      ? (_hasOverdue
          ? OverallState.overdue
          : _hasRisk
              ? OverallState.risk
              : _isOk
                  ? OverallState.ok
                  : OverallState.noInfo)
      : OverallState.noInfo;

  // TODO: перенос сюда выборок по подзадачам (сейчас в контроллере фильтра). Потому что это больше относится к бизнес-логике, а не к интерфейсу
}
