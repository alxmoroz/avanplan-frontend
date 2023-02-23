// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';
import 'tariff.dart';
import 'user.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace => Workspace(
        id: id,
        title: title?.trim() ?? '',
        description: description?.trim() ?? '',
        users: users?.map((u) => u.user) ?? [],
        tariff: wsTariff!.wsTariff,
      );
}
