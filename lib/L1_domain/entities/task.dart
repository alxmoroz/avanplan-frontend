// Copyright (c) 2022. Alexandr Moroz

import 'attachment.dart';
import 'base_entity.dart';
import 'feature_set.dart';
import 'note.dart';
import 'project_status.dart';
import 'task_member.dart';
import 'task_source.dart';

class TType {
  static const ROOT = 'ROOT';
  static const PROJECT = 'PROJECT';
  static const GOAL = 'GOAL';
  static const BACKLOG = 'BACKLOG';
  static const TASK = 'TASK';
  static const CHECKLIST_ITEM = 'CHECKLIST_ITEM';
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

class Project extends Titleable {
  Project({
    super.id,
    required super.title,
    required this.wsId,
    super.description,
    this.category,
    this.icon,
  });

  final int wsId;
  final String? category;
  final String? icon;
}

class Task extends Project {
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
    required super.wsId,
    this.taskSource,
    this.createdOn,
    this.updatedOn,
    this.dueDate,
    this.closedDate,
    this.projectStatusId,
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

  final DateTime? createdOn;
  final DateTime? updatedOn;

  final String type;
  final TaskState state;
  final double velocity;
  final double? requiredVelocity;
  final double progress;
  final DateTime? etaDate;

  final num? openedVolume;
  final num? closedVolume;
  final int? closedSubtasksCount;

  DateTime? startDate;
  bool closed;
  int? parentId;
  List<Note> notes;
  List<ProjectStatus> projectStatuses;

  List<Attachment> attachments;
  Iterable<TaskMember> members;
  Iterable<ProjectFeatureSet> projectFeatureSets;
  TaskSource? taskSource;

  DateTime? dueDate;
  DateTime? closedDate;
  int? projectStatusId;
  int? authorId;
  int? assigneeId;
  num? estimate;
}

class ProjectRemote extends Project {
  ProjectRemote({
    required super.title,
    required super.wsId,
    super.description,
    required this.taskSource,
    this.selected = false,
  });

  TaskSourceRemote? taskSource;
  bool selected;
}

class TasksChanges {
  TasksChanges(this.updated, this.affected);
  final Task? updated;
  final Iterable<Task> affected;
}
