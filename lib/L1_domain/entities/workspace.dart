// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate_value.dart';
import 'person.dart';
import 'priority.dart';
import 'source.dart';
import 'status.dart';
import 'ws_role.dart';
import 'ws_settings.dart';

class Workspace extends Titleable {
  Workspace({
    required super.id,
    required super.title,
    required super.description,
  });

  List<Status> statuses = [];
  List<Priority> priorities = [];
  List<Person> persons = [];
  List<Source> sources = [];
  List<EstimateValue> estimateValues = [];
  WSSettings? settings;

  List<WSRole> roles = [];
}
