// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_value.dart';
import 'invoice.dart';
import 'role.dart';
import 'source.dart';
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
    required this.wsMembers,
    required this.roles,
    required this.invoice,
    required this.balance,
    required this.settings,
    required this.estimateValues,
    required this.sources,
  });

  final Iterable<WSMember> wsMembers;
  final Iterable<Role> roles;
  Invoice invoice;
  num balance;

  final WSSettings? settings;

  // редактируемые поля
  List<EstimateValue> estimateValues;
  List<Source> sources;

  static Workspace get dummy => Workspace(
        id: -1,
        title: '',
        description: '',
        code: '',
        wsMembers: [],
        roles: [],
        invoice: Invoice.dummy,
        balance: 0,
        settings: null,
        estimateValues: [],
        sources: [],
      );

  num get balanceLack => invoice.tariff.estimateChargePerBillingPeriod - balance;
}
