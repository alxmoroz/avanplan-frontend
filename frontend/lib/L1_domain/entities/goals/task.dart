// Copyright (c) 2022. Alexandr Moroz

import 'smartable.dart';
import 'task_status.dart';

class Task extends Smartable {
  Task({
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

  final TaskStatus? status;
  List<Task> tasks;
}
