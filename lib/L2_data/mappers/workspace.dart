// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';
import 'invoice.dart';
import 'role.dart';
import 'tariff.dart';
import 'user.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace {
    final tariff = invoice!.tariff!.tariff;

    return Workspace(
      id: id,
      title: title?.trim() ?? '',
      description: description?.trim() ?? '',
      users: users?.map((u) => u.user) ?? [],
      roles: roles?.map((r) => r.role) ?? [],
      balance: balance ?? 0,
      invoice: invoice!.invoice,
    );
  }
}
