// Copyright (c) 2022. Alexandr Moroz

import 'smartable.dart';

class TaskUpsert extends SmartUpsert {
  TaskUpsert({
    required this.goalId,
    required String title,
    required String description,
    required bool closed,
    required DateTime? dueDate,
    int? id,
    int? parentId,
    int? statusId,
  }) : super(
          id: id,
          parentId: parentId,
          title: title,
          description: description,
          closed: closed,
          dueDate: dueDate,
          statusId: statusId,
        );

  final int goalId;
}
