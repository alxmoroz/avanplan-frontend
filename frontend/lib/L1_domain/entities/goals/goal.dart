// Copyright (c) 2022. Alexandr Moroz

import 'goal_report.dart';
import 'smartable.dart';
import 'task.dart';

class Goal extends Smartable {
  Goal({
    required int id,
    required DateTime createdOn,
    required DateTime updatedOn,
    required String title,
    required String description,
    required DateTime? dueDate,
    required int? parentId,
    required this.report,
    required this.tasks,
  }) : super(id: id, createdOn: createdOn, updatedOn: updatedOn, title: title, description: description, dueDate: dueDate, parentId: parentId) {
    _tasksCount = tasks.length;
    _closedTasksCount = tasks.where((Task t) => t.closed).length;
    _closedRatio = tasksCount > 0 ? closedTasksCount / tasksCount : null;
    _pace = (report?.factSpeed ?? 0) - (report?.planSpeed ?? 0);
  }

  final GoalReport? report;
  final Iterable<Task> tasks;

  int _tasksCount = 0;
  int get tasksCount => _tasksCount;

  int _closedTasksCount = 0;
  int get closedTasksCount => _closedTasksCount;

  double? _closedRatio;
  double? get closedRatio => _closedRatio;

  num _pace = 0;
  num get pace => _pace;

  DateTime? get etaDate => report?.etaDate;
}
