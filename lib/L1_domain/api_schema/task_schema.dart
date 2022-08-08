// Copyright (c) 2022. Alexandr Moroz

import 'base_upsert.dart';

class TaskUpsert extends StatusableUpsert {
  TaskUpsert({
    required int? id,
    required String title,
    required bool closed,
    required this.workspaceId,
    required this.parentId,
    required this.description,
    required this.dueDate,
    required this.statusId,
  }) : super(id: id, title: title, closed: closed);

  final int workspaceId;
  final int? parentId;
  final String description;
  final DateTime? dueDate;
  final int? statusId;
}

class TaskQuery {
  TaskQuery({
    required this.workspaceId,
    this.parentId,
  });

  final int workspaceId;
  final int? parentId;
}
