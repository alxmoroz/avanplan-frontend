// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_value.dart';
import 'invoice.dart';
import 'remote_source.dart';
import 'role.dart';
import 'user.dart';
import 'ws_member.dart';
import 'ws_settings.dart';

class WorkspaceUpsert extends Titleable {
  WorkspaceUpsert({
    required super.id,
    required super.title,
    required super.description,
    required this.code,
  });
  String code;
}

class Workspace extends WorkspaceUpsert {
  Workspace({
    required super.id,
    required super.title,
    required super.description,
    required super.code,
    required this.users,
    required this.members,
    required this.roles,
    required this.invoice,
    required this.balance,
    required this.settings,
    required this.estimateValues,
    required this.sources,
    required this.fsVolume,
    required this.tasksCount,
  });

  Iterable<User> users;
  Iterable<WSMember> members;
  Iterable<Role> roles;
  Invoice invoice;
  num balance;
  WSSettings? settings;

  // редактируемые поля
  List<EstimateValue> estimateValues;
  List<RemoteSource> sources;

  final num fsVolume;
  final int tasksCount;

  // TODO: похоже на атавизм. Остальных dummy тоже касается
  static Workspace get dummy => Workspace(
        id: -1,
        title: '',
        description: '',
        code: '',
        users: [],
        members: [],
        roles: [],
        invoice: Invoice.dummy,
        balance: 0,
        settings: null,
        estimateValues: [],
        sources: [],
        fsVolume: 0,
        tasksCount: 0,
      );
}
