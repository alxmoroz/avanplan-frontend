// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'estimate.dart';
import 'person.dart';
import 'priority.dart';
import 'source.dart';
import 'status.dart';
import 'ws_role.dart';
import 'ws_settings.dart';

class Workspace extends Codable {
  Workspace({
    required super.id,
    required super.code,
    required this.statuses,
    required this.estimates,
    required this.priorities,
    required this.persons,
    required this.sources,
    required this.title,
    required this.description,
    required this.settings,
  });

  final List<Status> statuses;
  final List<Priority> priorities;
  final List<Person> persons;
  final List<Source> sources;
  final List<Estimate> estimates;

  final String title;
  final String description;

  final WSSettings? settings;

  List<WSRole> roles = [];
}
