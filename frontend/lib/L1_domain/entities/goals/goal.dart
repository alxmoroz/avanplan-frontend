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
    required List<Task> tasks,
    required this.status,
  }) : super(
          id: id,
          createdOn: createdOn,
          updatedOn: updatedOn,
          title: title,
          description: description,
          dueDate: dueDate,
          parentId: parentId,
          closed: closed,
          tasks: tasks,
        );

  final GoalStatus? status;

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
}
