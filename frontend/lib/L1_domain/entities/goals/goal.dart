// Copyright (c) 2022. Alexandr Moroz

import '../auth/workspace.dart';
import 'smartable.dart';
import 'task.dart';

class Goal extends Smartable {
  Goal({
    required this.workspace,
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

  final Workspace workspace;

  Goal copy() => Goal(
        workspace: workspace,
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
