// Copyright (c) 2022. Alexandr Moroz

import 'account.dart';
import 'base_entity.dart';
import 'estimate_value.dart';
import 'invoice.dart';
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
    required this.roles,
    required this.invoice,
    required this.balance,
    required this.settings,
    required this.estimateValues,
    required this.sources,
    required this.mainAccount,
  });

  final Iterable<User> users;
  final Iterable<Role> roles;
  Invoice invoice;
  final num balance;
  final WSettings? settings;
  final Iterable<EstimateValue> estimateValues;
  List<Source> sources = [];
  final Account mainAccount;
}
