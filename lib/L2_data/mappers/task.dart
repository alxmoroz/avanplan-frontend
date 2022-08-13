// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/task.dart';
import 'person.dart';
import 'priority.dart';
import 'status.dart';
import 'task_source.dart';

extension TaskMapper on api.TaskGet {
  Task task([Task? _parent]) {
    final _t = Task(
      id: id,
      createdOn: createdOn.toLocal(),
      updatedOn: updatedOn.toLocal(),
      title: title.trim(),
      description: description?.trim() ?? '',
      dueDate: dueDate?.toLocal(),
      closed: closed ?? false,
      status: status?.status,
      tasks: [],
      priority: priority?.priority,
      author: author?.person,
      assignee: assignee?.person,
      workspaceId: workspaceId,
      taskSource: taskSource?.taskSource,
      parent: _parent,
    );
    _t.tasks = tasks?.map((t) => t.task(_t)).toList() ?? [];
    return _t;
  }
}

extension TaskImportMapper on api.Task {
  TaskImport get taskImport => TaskImport(
        title: title,
        description: description ?? '',
        taskSource: taskSource?.taskSourceImport,
      );
}
