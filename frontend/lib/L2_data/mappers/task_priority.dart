// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/task_priority.dart';

extension TaskPriorityMapper on TaskPrioritySchemaGet {
  TaskPriority get priority => TaskPriority(
        id: id,
        title: title,
        order: order,
        workspaceId: workspaceId,
      );
}
