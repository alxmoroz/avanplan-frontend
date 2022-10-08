// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'person.dart';
import 'priority.dart';
import 'source.dart';
import 'status.dart';
import 'ws_role.dart';

class Workspace extends Titleable {
  Workspace({
    required super.id,
    required super.title,
    required this.statuses,
    required this.priorities,
    required this.persons,
    required this.sources,
    this.description = '',
  });

  final List<Status> statuses;
  final List<Priority> priorities;
  final List<Person> persons;
  final List<Source> sources;

  final String description;

  List<WSRole> roles = [];
}
