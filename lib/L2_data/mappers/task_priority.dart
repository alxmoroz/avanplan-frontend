// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/ew_priority.dart';

extension TaskPriorityMapper on TaskPrioritySchemaGet {
  EWPriority get priority => EWPriority(
        id: id,
        title: title,
        order: order,
        workspaceId: workspaceId,
      );
}
