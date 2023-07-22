// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'member.dart';
import 'note.dart';
import 'project_status.dart';
import 'task_source.dart';
import 'workspace.dart';

enum TaskLevel { root, project, goal, task, subtask }

enum TaskState {
  overdue,
  risk,
  ok,
  closable,
  futureStart,
  eta,
  noSubtasks,
  noProgress,
  today,
  thisWeek,
  futureDue,
  noDue,
  noInfo,
  opened,
  closed,
}

class Task extends Titleable {
  Task({
    super.id,
    super.description,
    super.title,
    required this.closed,
    required this.parent,
    required this.tasks,
    required this.notes,
    required this.members,
    required this.projectStatuses,
    required this.ws,
    this.createdOn,
    this.updatedOn,
    this.dueDate,
    this.startDate,
    this.closedDate,
    this.statusId,
    this.authorId,
    this.assigneeId,
    this.taskSource,
    this.type,
    this.estimate,
  });

  Task? parent;

  List<Task> tasks;
  List<Note> notes;
  Iterable<Member> members;
  Iterable<ProjectStatus> projectStatuses;
  int? statusId;
  bool closed;

  final DateTime? createdOn;
  final DateTime? updatedOn;
  DateTime? startDate;
  DateTime? closedDate;
  DateTime? dueDate;

  final Workspace ws;

  int? authorId;
  int? assigneeId;

  final TaskSource? taskSource;
  final String? type;
  int? estimate;

  TaskLevel level = TaskLevel.root;

  Iterable<Task> allTasks = [];
  Iterable<Task> openedSubtasks = [];
  Iterable<Task> goalsForLocalExport = [];
  Iterable<Task> goalsForLocalImport = [];
  Iterable<Task> closedSubtasks = [];
  Iterable<Task> leaves = [];
  Iterable<Task> openedLeaves = [];
  Iterable<Task> openedAssignedLeaves = [];
  Iterable<Task> closedLeaves = [];
  Iterable<Task> overdueSubtasks = [];
  Iterable<Task> riskySubtasks = [];
  Iterable<Task> okSubtasks = [];
  Iterable<Task> etaSubtasks = [];

  late Duration beforeStartPeriod;
  bool isFuture = false;
  late Duration elapsedPeriod;
  bool? isLowStart;
  Duration? etaPeriod;
  DateTime? etaDate;
  Duration? closedPeriod;

  Duration? leftPeriod;
  Duration? riskPeriod;

  double? velocityTasks;
  double? velocitySP;
  double? targetVelocity;
  bool showSP = false;

  double? planVolume;

  late TaskState state;
  late TaskState subtasksState;
  late TaskState overallState;

  static Task get dummy => Task(title: '', closed: false, parent: null, tasks: [], members: [], notes: [], projectStatuses: [], ws: Workspace.dummy);
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

class TaskQuery {
  TaskQuery({
    required this.wsId,
    this.parentId,
  });

  final int wsId;
  final int? parentId;
}
