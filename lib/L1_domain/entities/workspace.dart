// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'person.dart';
import 'priority.dart';
import 'remote_tracker.dart';
import 'status.dart';

class Workspace extends Titleable {
  Workspace({
    required int id,
    required String title,
    required this.statuses,
    required this.priorities,
    required this.persons,
    required this.remoteTrackers,
  }) : super(id: id, title: title);

  final List<Status> statuses;
  final List<Priority> priorities;
  final List<Person> persons;
  final List<RemoteTracker> remoteTrackers;
}
