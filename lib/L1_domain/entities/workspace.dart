// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_value.dart';
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

  List<Source> sources = [];
  List<EstimateValue> estimateValues = [];
  WSettings? settings;

  // List<Status> statuses = [];
  // List<Priority> priorities = [];
}
