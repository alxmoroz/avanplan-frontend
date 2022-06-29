// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/element_of_work.dart';
import 'task_priority.dart';
import 'task_status.dart';

extension TaskMapper on TaskSchemaGet {
  ElementOfWork get task => ElementOfWork(
        id: id,
        parentId: parentId,
        createdOn: createdOn.toLocal(),
        updatedOn: updatedOn.toLocal(),
        title: title.trim(),
        description: description?.trim() ?? '',
        dueDate: dueDate?.toLocal(),
        closed: closed,
        status: status?.status,
        ewList: tasks?.map((t) => t.task).toList() ?? [],
        trackerId: remoteTrackerId,
        priority: priority?.priority,
      );
}
