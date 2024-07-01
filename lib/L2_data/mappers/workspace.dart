// Copyright (c) 2024. Alexandr Moroz

import 'package:openapi/openapi.dart' as api;

import '../../L1_domain/entities/workspace.dart';
import 'estimate_value.dart';
import 'invoice.dart';
import 'member.dart';
import 'role.dart';
import 'source.dart';
import 'user.dart';
import 'ws_settings.dart';

extension WorkspaceMapper on api.WorkspaceGet {
  Workspace get workspace {
    final ws = Workspace(
      id: id,
      code: code,
      title: title.trim(),
      description: description?.trim() ?? '',
      users: users?.map((u) => u.user(id)) ?? [],
      members: members?.map((m) => m.wsMember(id)) ?? [],
      roles: roles?.map((r) => r.role) ?? [],
      balance: balance ?? 0,
      invoice: invoice!.invoice,
      settings: settings?.settings,
      estimateValues: estimateValues?.map((ev) => ev.estimateValue(id)).toList() ?? [],
      sources: [],
      fsVolume: fsVolume ?? 0,
      tasksCount: tasksCount ?? 0,
    );
    ws.sources = sources?.map((s) => s.source(id)).toList() ?? [];
    return ws;
  }
}
