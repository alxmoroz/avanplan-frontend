// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'goal.dart';
import 'person.dart';
import 'remote_tracker.dart';
import 'task_priority.dart';
import 'task_status.dart';

class Workspace extends Titleable {
  Workspace({
    required int id,
    required String title,
    required this.goals,
    required this.taskStatuses,
    required this.taskPriorities,
    required this.persons,
    required this.remoteTrackers,
  }) : super(id: id, title: title);

  final List<Goal> goals;
  final List<TaskStatus> taskStatuses;
  final List<TaskPriority> taskPriorities;
  final List<Person> persons;
  final List<RemoteTracker> remoteTrackers;
}
