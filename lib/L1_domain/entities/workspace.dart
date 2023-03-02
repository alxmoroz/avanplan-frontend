// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_value.dart';
import 'role.dart';
import 'source.dart';
import 'tariff.dart';
import 'user.dart';
import 'ws_settings.dart';

class Workspace extends Titleable {
  Workspace({
    required super.id,
    required super.title,
    required super.description,
    required this.users,
    required this.roles,
    required this.tariff,
    required this.limitsMap,
  });

  final Iterable<User> users;
  final Iterable<Role> roles;
  final Tariff tariff;
  final Map<String, int> limitsMap;

  Iterable<Source> sources = [];
  Iterable<EstimateValue> estimateValues = [];
  WSettings? settings;

  // List<Status> statuses = [];
  // List<Priority> priorities = [];
}
