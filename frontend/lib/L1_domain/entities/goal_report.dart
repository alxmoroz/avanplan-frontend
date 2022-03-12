// Copyright (c) 2022. Alexandr Moroz

class GoalReport {
  GoalReport({
    this.tasksCount,
    this.closedTasksCount,
    this.etaDate,
    this.factSpeed,
    this.planSpeed,
  });

  final int? tasksCount;
  final int? closedTasksCount;
  final DateTime? etaDate;
  final num? factSpeed;
  final num? planSpeed;
}
