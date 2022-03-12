// Copyright (c) 2022. Alexandr Moroz

// TODO: повторить структуру Л1 с бэка

import 'goal_report.dart';

class Goal {
  Goal({
    this.id,
    this.title = '',
    this.description,
    this.dueDate,
    this.report,
  });

  final int? id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final GoalReport? report;
}
