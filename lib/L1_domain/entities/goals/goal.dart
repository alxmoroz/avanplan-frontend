// Copyright (c) 2022. Alexandr Moroz

import 'element_of_work.dart';
import 'task.dart';

class Goal extends ElementOfWork {
  Goal({
    required this.workspaceId,
    required int id,
    required DateTime createdOn,
    required DateTime updatedOn,
    required String title,
    required String description,
    required DateTime? dueDate,
    required int? parentId,
    required int? trackerId,
    required bool closed,
    required List<Task> tasks,
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
          trackerId: trackerId,
        );

  final int workspaceId;

  Goal copy() => Goal(
        workspaceId: workspaceId,
        id: id,
        parentId: parentId,
        createdOn: createdOn,
        updatedOn: updatedOn,
        title: title,
        description: description,
        dueDate: dueDate,
        tasks: tasks,
        closed: closed,
        trackerId: trackerId,
      );
}
