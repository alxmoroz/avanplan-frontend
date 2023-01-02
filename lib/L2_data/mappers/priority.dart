// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/priority.dart';

extension PriorityMapper on api.PriorityGet {
  Priority get priority => Priority(
        id: id,
        code: code,
        order: order,
        workspaceId: workspaceId,
      );
}
