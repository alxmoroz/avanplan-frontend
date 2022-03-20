// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/task.dart';
import 'task_status.dart';

extension TaskMapper on TaskSchemaGet {
  Task get task => Task(
        id: id,
        parentId: parentId,
        createdOn: createdOn.toLocal(),
        updatedOn: updatedOn.toLocal(),
        title: title,
        description: description ?? '',
        dueDate: dueDate?.toLocal(),
        status: status != null ? status!.status : null,
        tasks: tasks?.map((t) => t.task) ?? [],
      );
}
