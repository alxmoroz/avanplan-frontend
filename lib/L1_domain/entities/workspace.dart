// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'element_of_work.dart';
import 'ew_priority.dart';
import 'ew_status.dart';
import 'person.dart';
import 'remote_tracker.dart';

class Workspace extends Titleable {
  Workspace({
    required int id,
    required String title,
    required this.ewList,
    required this.ewStatuses,
    required this.ewPriorities,
    required this.persons,
    required this.remoteTrackers,
  }) : super(id: id, title: title);

  final List<ElementOfWork> ewList;
  final List<EWStatus> ewStatuses;
  final List<EWPriority> ewPriorities;
  final List<Person> persons;
  final List<RemoteTracker> remoteTrackers;
}
