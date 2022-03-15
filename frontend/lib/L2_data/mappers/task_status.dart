// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/goals/task_status.dart';

extension TaskStatusMapper on TaskStatusSchemaGet {
  TaskStatus get status => TaskStatus(
        id: id,
        title: title,
        closed: closed,
      );
}
