// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'person.dart';
import 'priority.dart';
import 'status.dart';
import 'task_source.dart';

enum TaskLevel { workspace, project, goal, task, subtask }

enum TaskState {
  overdue,
  risk,
  ok,
  closable,
  future,
  eta,
  noSubtasks,
  noProgress,
  noInfo,
  opened,
  closed,
}

class Task extends Titleable {
  Task({
    super.id,
    super.description,
    required super.title,
    required this.closed,
    required this.parent,
    required this.tasks,
    required this.workspaceId,
    this.createdOn,
    this.updatedOn,
    this.dueDate,
    this.startDate,
    this.closedDate,
    this.status,
    this.priority,
    this.author,
    this.assignee,
    this.taskSource,
    this.type,
    this.estimate,
  });

  List<Task> tasks;
  final DateTime? createdOn;
  final DateTime? updatedOn;
  DateTime? startDate;
  DateTime? closedDate;
  final DateTime? dueDate;
  final int workspaceId;
  final Status? status;
  final Priority? priority;
  final Person? author;
  final Person? assignee;
  final TaskSource? taskSource;
  final String? type;
  int? estimate;
  Task? parent;
  bool closed;

  TaskLevel level = TaskLevel.workspace;

  Iterable<Task> allTasks = [];
  Iterable<Task> openedSubtasks = [];
  Iterable<Task> closedSubtasks = [];
  Iterable<Task> leafTasks = [];
  Iterable<Task> openedLeafTasks = [];
  Iterable<Task> closedLeafTasks = [];
  Iterable<Task> overdueSubtasks = [];
  Iterable<Task> riskySubtasks = [];
  Iterable<Task> okSubtasks = [];
  Iterable<Task> etaSubtasks = [];

  late Duration beforeStartPeriod;
  bool isFuture = false;
  late Duration elapsedPeriod;
  bool? isLowStart;
  Duration? overduePeriod;
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
}

class TaskImport {
  TaskImport({
    required this.title,
    required this.description,
    required this.taskSource,
    this.selected = true,
  });

  final String title;
  final String description;
  TaskSourceImport? taskSource;
  bool selected;
}

class TaskQuery {
  TaskQuery({
    required this.workspaceId,
    this.parentId,
  });

  final int workspaceId;
  final int? parentId;
}
