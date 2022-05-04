// Copyright (c) 2022. Alexandr Moroz

import 'smartable.dart';

class GoalUpsert extends SmartUpsert {
  GoalUpsert({
    required this.workspaceId,
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
          closed: closed,
          description: description,
          dueDate: dueDate,
          statusId: statusId,
        );

  final int workspaceId;
}
