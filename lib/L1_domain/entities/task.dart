// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'person.dart';
import 'priority.dart';
import 'status.dart';
import 'task_source.dart';

class TaskType extends Titleable {
  TaskType({required super.id, required super.title});
}

class Task extends Statusable {
  Task({
    super.id,
    required super.title,
    required super.closed,
    required this.parent,
    required this.tasks,
    this.description = '',
    this.createdOn,
    this.updatedOn,
    this.dueDate,
    this.startDate,
    this.workspaceId,
    this.status,
    this.priority,
    this.author,
    this.assignee,
    this.taskSource,
    this.type,
  });

  List<Task> tasks;
  final String description;

  final DateTime? createdOn;
  final DateTime? updatedOn;
  final DateTime? startDate;
  final DateTime? dueDate;
  final int? workspaceId;
  final Status? status;
  final Priority? priority;
  final Person? author;
  final Person? assignee;
  final TaskSource? taskSource;
  final TaskType? type;
  Task? parent;

  // TODO(san-smith): возможно заинтересует пакет freezed - он из коробки предоставляет метод copyWith и toString
  // https://pub.dev/packages/freezed
  Task copy() => Task(
        id: id,
        title: title,
        closed: closed,
        description: description,
        createdOn: createdOn,
        updatedOn: updatedOn,
        parent: parent,
        tasks: tasks,
        dueDate: dueDate,
        startDate: startDate,
        workspaceId: workspaceId,
        status: status,
        priority: priority,
        author: author,
        assignee: assignee,
        taskSource: taskSource,
        type: type,
      );
}

class TaskImport {
  TaskImport({
    required this.title,
    required this.description,
    required this.taskSource,
    this.selected = true,
  });

  final String title;
  final String description;
  TaskSourceImport? taskSource;
  bool selected;
}

class TaskQuery {
  TaskQuery({
    required this.workspaceId,
    this.parentId,
  });

  final int workspaceId;
  final int? parentId;
}
