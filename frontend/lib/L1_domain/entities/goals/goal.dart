// Copyright (c) 2022. Alexandr Moroz

import 'goal_report.dart';
import 'goal_status.dart';
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
    required this.status,
    required this.report,
    required this.tasks,
  }) : super(id: id, createdOn: createdOn, updatedOn: updatedOn, title: title, description: description, dueDate: dueDate, parentId: parentId);

  final GoalStatus? status;
  final GoalReport? report;
  List<Task> tasks;

  int get tasksCount => tasks.length;
  int get closedTasksCount => tasks.where((t) => t.closed).length;
  double? get closedRatio => tasksCount > 0 ? closedTasksCount / tasksCount : null;
  num get pace => (report?.factSpeed ?? 0) - (report?.planSpeed ?? 0);

  DateTime? get etaDate => report?.etaDate;

  Goal copy() => Goal(
        id: id,
        parentId: parentId,
        createdOn: createdOn,
        updatedOn: updatedOn,
        title: title,
        description: description,
        dueDate: dueDate,
        status: status,
        report: report,
        tasks: tasks,
      );
}
