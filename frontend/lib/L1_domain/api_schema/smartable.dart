// Copyright (c) 2022. Alexandr Moroz

class SmartUpsert {
  SmartUpsert({
    required this.id,
    required this.parentId,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.statusId,
    required this.closed,
  });

  final int? id;
  final int? parentId;
  final String title;
  final String description;
  final bool closed;
  final DateTime? dueDate;
  final int? statusId;
}
