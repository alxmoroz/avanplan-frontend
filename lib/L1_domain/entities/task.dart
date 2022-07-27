// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'priority.dart';
import 'status.dart';

class Task extends Statusable {
  Task({
    required int id,
    required String title,
    required bool closed,
    required this.description,
    required this.createdOn,
    required this.updatedOn,
    required this.tasks,
    this.dueDate,
    this.parentId,
    this.workspaceId,
    this.status,
    this.priority,
    this.trackerId,
    this.remoteCode,
  }) : super(id: id, title: title, closed: closed);

  final String description;
  final DateTime createdOn;
  final DateTime updatedOn;
  List<Task> tasks;

  final DateTime? dueDate;
  final int? parentId;
  final int? workspaceId;
  final Status? status;
  final Priority? priority;
  final int? trackerId;
  final String? remoteCode;

  Task copy() => Task(
        id: id,
        title: title,
        closed: closed,
        description: description,
        createdOn: createdOn,
        updatedOn: updatedOn,
        tasks: tasks,
        dueDate: dueDate,
        parentId: parentId,
        workspaceId: workspaceId,
        status: status,
        priority: priority,
        trackerId: trackerId,
        remoteCode: remoteCode,
      );
}
