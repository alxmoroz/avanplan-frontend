// Copyright (c) 2022. Alexandr Moroz

class GoalReport {
  GoalReport({
    this.tasksCount = 0,
    this.closedTasksCount = 0,
    this.factSpeed = 0,
    this.planSpeed = 0,
    this.etaDate,
  });

  final int tasksCount;
  final int closedTasksCount;
  final num factSpeed;
  final num planSpeed;
  final DateTime? etaDate;
}
