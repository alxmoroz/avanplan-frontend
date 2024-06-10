// Copyright (c) 2024. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_value.dart';
import 'invoice.dart';
import 'member.dart';
import 'role.dart';
import 'source.dart';
import 'user.dart';
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
  });

  final Iterable<User> users;
  final Iterable<WSMember> members;
  final Iterable<Role> roles;
  Invoice invoice;
  num balance;

  final WSSettings? settings;

  // редактируемые поля
  List<EstimateValue> estimateValues;
  List<Source> sources;

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
      );
}
