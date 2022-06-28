// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goal.dart';
import 'task.dart';

extension GoalMapper on GoalSchemaGet {
  Goal get goal => Goal(
        id: id,
        workspaceId: workspaceId,
        parentId: parentId,
        createdOn: createdOn.toLocal(),
        updatedOn: updatedOn.toLocal(),
        title: title.trim(),
        description: description?.trim() ?? '',
        dueDate: dueDate?.toLocal(),
        closed: closed,
        tasks: tasks?.map((t) => t.task).toList() ?? [],
        trackerId: remoteTrackerId,
      );
}
