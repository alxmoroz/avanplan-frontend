// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'member.dart';
import 'note.dart';
import 'project_status.dart';
import 'task_source.dart';
import 'workspace.dart';

class TType {
  static const String ROOT = 'ROOT';
  static const String PROJECT = 'PROJECT';
  static const String GOAL = 'GOAL';
  static const String GROUP = 'GROUP';
  static const String BACKLOG = 'BACKLOG';
  static const String TASK = 'TASK';
}

enum TaskState {
  OVERDUE,
  RISK,
  OK,
  AHEAD,
  CLOSABLE,
  FUTURE_START,
  LOW_START,
  ETA,
  NO_PROGRESS,
  NO_SUBTASKS,
  TODAY,
  THIS_WEEK,
  FUTURE_DUE,
  NO_DUE,
  NO_INFO,
  CLOSED,
}

class Task extends Titleable {
  Task({
    super.id,
    super.description,
    super.title,
    required this.startDate,
    required this.closed,
    required this.parentId,
    required this.notes,
    required this.members,
    required this.projectStatuses,
    required this.ws,
    this.taskSource,
    this.createdOn,
    this.updatedOn,
    this.dueDate,
    this.closedDate,
    this.statusId,
    this.authorId,
    this.assigneeId,
    this.type = 'TASK',
    this.estimate,
    this.state = TaskState.NO_INFO,
    this.velocity = 0,
    this.requiredVelocity,
    this.progress = 0,
    this.etaDate,
    this.openedVolume,
    this.closedVolume,
    this.closedSubtasksCount,
  });

  DateTime? startDate;
  bool closed;
  int? parentId;
  List<Note> notes;
  Iterable<Member> members;
  Iterable<ProjectStatus> projectStatuses;
  final Workspace ws;
  final TaskSource? taskSource;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  DateTime? dueDate;
  DateTime? closedDate;
  int? statusId;
  int? authorId;
  int? assigneeId;
  final String type;

  num? estimate;
  final TaskState state;
  final double velocity;
  final double? requiredVelocity;
  final double progress;
  final DateTime? etaDate;

  final num? openedVolume;
  final num? closedVolume;
  final int? closedSubtasksCount;
}

class TaskRemote {
  TaskRemote({
    required this.title,
    required this.description,
    required this.taskSource,
    this.selected = false,
  });

  final String title;
  final String description;
  TaskSourceImport? taskSource;
  bool selected;
}

class TasksChanges {
  TasksChanges(this.updated, this.affected);
  final Task? updated;
  final Iterable<Task> affected;
}
