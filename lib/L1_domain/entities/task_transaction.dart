// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

class TaskTransaction extends WSBounded {
  TaskTransaction({
    super.id,
    required super.wsId,
    required this.taskId,
    required this.amount,
    required this.category,
    required this.description,
    this.authorId,
    super.createdOn,
  });

  final int taskId;
  final num amount;
  final String category;
  final String description;

  final int? authorId;
}
