// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';
import 'account.dart';
import 'estimate_value.dart';
import 'invoice.dart';
import 'role.dart';
import 'source.dart';
import 'user.dart';
import 'w_settings.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace {
    final ws = Workspace(
      id: id,
      code: code,
      title: title.trim(),
      description: description?.trim() ?? '',
      users: users?.map((u) => u.user(id)) ?? [],
      roles: roles?.map((r) => r.role) ?? [],
      balance: balance ?? 0,
      invoice: invoice!.invoice,
      settings: settings?.settings,
      estimateValues: estimateValues?.map((ev) => ev.estimateValue(id)).toList() ?? [],
      mainAccount: mainAccount!.account,
      tasksCount: tasksCount ?? 0,
      sources: [],
    );
    ws.sources = sources?.map((s) => s.source(id)).toList() ?? [];
    return ws;
  }
}
