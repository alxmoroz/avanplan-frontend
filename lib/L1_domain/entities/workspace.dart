// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_value.dart';
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
  });

  final List<User> users;

  Iterable<Source> sources = [];
  Iterable<EstimateValue> estimateValues = [];
  WSettings? settings;
  Iterable<Role> roles = [];

  // List<Status> statuses = [];
  // List<Priority> priorities = [];
}
