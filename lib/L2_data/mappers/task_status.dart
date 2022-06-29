// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/ew_status.dart';

extension TaskStatusMapper on TaskStatusSchemaGet {
  EWStatus get status => EWStatus(
        id: id,
        title: title,
        closed: closed,
        workspaceId: workspaceId,
      );
}
