// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_value.dart';
import 'invoice.dart';
import 'role.dart';
import 'source.dart';
import 'user.dart';
import 'ws_settings.dart';

class Workspace extends Titleable {
  Workspace({
    required super.id,
    required super.title,
    required super.description,
    required this.users,
    required this.roles,
    required this.invoice,
    required this.balance,
  });

  final Iterable<User> users;
  final Iterable<Role> roles;
  final num balance;
  Invoice invoice;

  Iterable<Source> sources = [];
  Iterable<EstimateValue> estimateValues = [];
  WSettings? settings;
}
