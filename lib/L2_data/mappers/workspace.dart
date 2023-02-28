// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';
import 'contract.dart';
import 'role.dart';
import 'tariff.dart';
import 'user.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace => Workspace(
        id: id,
        title: title?.trim() ?? '',
        description: description?.trim() ?? '',
        users: users?.map((u) => u.user) ?? [],
        contract: contract!.contract,
        tariff: tariff!.tariff,
        limitsMap: {for (var l in tariff!.limits) l.code: l.value},
        roles: roles?.map((r) => r.role) ?? [],
      );
}
