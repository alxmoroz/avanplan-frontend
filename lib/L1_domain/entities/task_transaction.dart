// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';

class TaskTransaction extends WSBounded implements Comparable {
  TaskTransaction({
    super.id,
    required super.wsId,
    required this.taskId,
    super.createdOn,
    this.authorId,
    required this.amount,
    required this.category,
    required this.description,
  });

  final int taskId;
  final int? authorId;

  num amount;
  String category;
  String description;

  @override
  int compareTo(other) => other.createdOn!.compareTo(createdOn!);
}
