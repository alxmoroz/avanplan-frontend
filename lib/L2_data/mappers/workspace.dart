// Copyright (c) 2022. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';
import 'estimate_value.dart';
import 'invoice.dart';
import 'role.dart';
import 'source.dart';
import 'ws_member.dart';
import 'ws_settings.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace {
    final ws = Workspace(
      id: id,
      code: code,
      title: title.trim(),
      description: description?.trim() ?? '',
      wsMembers: users?.map((u) => u.wsMember(id)) ?? [],
      roles: roles?.map((r) => r.role) ?? [],
      balance: balance ?? 0,
      invoice: invoice!.invoice,
      settings: settings?.settings,
      estimateValues: estimateValues?.map((ev) => ev.estimateValue(id)).toList() ?? [],
      sources: [],
    );
    ws.sources = sources?.map((s) => s.source(id)).toList() ?? [];
    return ws;
  }
}
