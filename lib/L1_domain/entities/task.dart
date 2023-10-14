// Copyright (c) 2022. Alexandr Moroz

import 'attachment.dart';
import 'base_entity.dart';
import 'feature_set.dart';
import 'member.dart';
import 'note.dart';
import 'status.dart';
import 'task_source.dart';
import 'workspace.dart';

class TType {
  static const ROOT = 'ROOT';
  static const PROJECT = 'PROJECT';
  static const GOAL = 'GOAL';
  static const GROUP = 'GROUP';
  static const BACKLOG = 'BACKLOG';
  static const TASK = 'TASK';
}

enum TaskState {
  OVERDUE,
  RISK,
  AHEAD,
  OK,
  CLOSABLE,
  FUTURE_START,
  ETA,
  NO_SUBTASKS,
  NO_PROGRESS,
  LOW_START,
  NO_INFO,
  TODAY,
  THIS_WEEK,
  FUTURE_DUE,
  NO_DUE,
  BACKLOG,
  IMPORTING,
  CLOSED,
}

class Task extends Titleable {
  Task({
    super.id,
    required super.title,
    super.description,
    required this.startDate,
    required this.closed,
    required this.parentId,
    required this.notes,
    required this.attachments,
    required this.members,
    required this.projectStatuses,
    required this.projectFeatureSets,
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
  Iterable<Attachment> attachments;
  Iterable<Member> members;
  Iterable<ProjectStatus> projectStatuses;
  Iterable<ProjectFeatureSet> projectFeatureSets;
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
    required this.type,
    this.selected = false,
  });

  final String title;
  final String type;
  final String description;
  TaskSourceRemote? taskSource;
  bool selected;
}

class TasksChanges {
  TasksChanges(this.updated, this.affected);
  final Task? updated;
  final Iterable<Task> affected;
}
