// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'priority.dart';
import 'status.dart';

class Task extends Statusable {
  Task({
    required int id,
    required String title,
    required bool closed,
    required this.tasks,
    required this.description,
    required this.createdOn,
    required this.updatedOn,
    required this.dueDate,
    required this.parentId,
    required this.trackerId,
    this.workspaceId,
    this.status,
    this.priority,
  }) : super(id: id, title: title, closed: closed);

  final String description;
  final DateTime createdOn;
  final DateTime updatedOn;
  final DateTime? dueDate;
  final int? parentId;
  final int? trackerId;
  final Status? status;
  final Priority? priority;
  final int? workspaceId;
  List<Task> tasks;

  Task copy() => Task(
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
        workspaceId: workspaceId,
      );
}
