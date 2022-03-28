// Copyright (c) 2022. Alexandr Moroz

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
    required bool closed,
    required this.status,
    required this.tasks,
  }) : super(
          id: id,
          createdOn: createdOn,
          updatedOn: updatedOn,
          title: title,
          description: description,
          dueDate: dueDate,
          parentId: parentId,
          closed: closed,
        );

  final GoalStatus? status;
  List<Task> tasks;

  Goal copy() => Goal(
        id: id,
        parentId: parentId,
        createdOn: createdOn,
        updatedOn: updatedOn,
        title: title,
        description: description,
        dueDate: dueDate,
        status: status,
        tasks: tasks,
        closed: closed,
      );

  int get tasksCount => tasks.length;
  int get closedTasksCount => tasks.where((t) => t.closed).length;
  int get lefTasksCount => tasksCount - closedTasksCount;
  double? get closedRatio => tasksCount > 0 ? closedTasksCount / tasksCount : null;

  double get _factSpeed => closedTasksCount / pastPeriod.inSeconds;
  double get _planSpeed => tasksCount / (plannedPeriod?.inSeconds ?? 1);

  DateTime? get etaDate => _factSpeed > 0 ? DateTime.now().add(Duration(seconds: (lefTasksCount / _factSpeed).round())) : null;
  double get pace => _factSpeed - _planSpeed;
}
