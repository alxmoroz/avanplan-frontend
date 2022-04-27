// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart';

import '../../L1_domain/entities/auth/workspace.dart';

extension WorkspaceMapper on WorkspaceSchemaGet {
  Workspace get workspace => Workspace(
        id: id,
        title: title.trim(),
      );
}
