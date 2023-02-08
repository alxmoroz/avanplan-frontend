// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L2_data/mappers/user.dart';
import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace => Workspace(
        id: id,
        title: title?.trim() ?? '',
        description: description?.trim() ?? '',
        users: users?.map((u) => u.user).toList() ?? [],
      );
}
