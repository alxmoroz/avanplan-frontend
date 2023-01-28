// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/priority.dart';

extension PriorityMapper on api.PriorityGet {
  Priority priority(int wsId) => Priority(
        id: id,
        code: code,
        order: order,
        workspaceId: wsId,
      );
}
