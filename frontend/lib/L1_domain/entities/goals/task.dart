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
    required this.status,
  }) : super(id: id, createdOn: createdOn, updatedOn: updatedOn, title: title, description: description, dueDate: dueDate);

  final TaskStatus? status;

  bool get closed => status?.closed ?? false;
}
