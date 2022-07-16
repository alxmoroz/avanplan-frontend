// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/priority.dart';

extension PriorityMapper on PrioritySchemaGet {
  Priority get priority => Priority(
        id: id,
        title: title,
        order: order,
        workspaceId: workspaceId,
      );
}
