// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';
import 'account.dart';
import 'estimate_value.dart';
import 'invoice.dart';
import 'priority.dart';
import 'role.dart';
import 'source.dart';
import 'status.dart';
import 'user.dart';
import 'w_settings.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace {
    return Workspace(
      id: id,
      code: code,
      title: title?.trim() ?? '',
      description: description?.trim() ?? '',
      users: users?.map((u) => u.user(id)) ?? [],
      roles: roles?.map((r) => r.role) ?? [],
      balance: balance ?? 0,
      invoice: invoice!.invoice(id),
      settings: settings?.settings(id),
      estimateValues: estimateValues?.map((ev) => ev.estimateValue(id)).toList() ?? [],
      sources: sources?.map((s) => s.source(id)).toList() ?? [],
      statuses: statuses?.map((st) => st.status(id)).toList() ?? [],
      priorities: priorities?.map((p) => p.priority(id)).toList() ?? [],
      mainAccount: mainAccount!.account(id),
    );
  }
}
