// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/task.dart';
import 'priority.dart';
import 'status.dart';
import 'task_source.dart';

extension TaskMapper on TaskGet {
  Task get task => Task(
        id: id,
        parentId: parentId,
        createdOn: createdOn.toLocal(),
        updatedOn: updatedOn.toLocal(),
        title: title.trim(),
        description: description?.trim() ?? '',
        dueDate: dueDate?.toLocal(),
        closed: closed ?? false,
        status: status?.status,
        tasks: tasks?.map((t) => t.task).toList() ?? [],
        priority: priority?.priority,
        workspaceId: workspaceId,
        taskSource: taskSource?.taskSource,
      );
}
