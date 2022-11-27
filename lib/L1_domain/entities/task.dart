// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'person.dart';
import 'priority.dart';
import 'status.dart';
import 'task_source.dart';

class TaskType extends Titleable {
  TaskType({required super.id, required super.title});
}

enum TaskLevel { workspace, project, goal, task, subtask }

enum TaskState {
  overdue,
  risk,
  closable,
  noSubtasks,
  eta,
  noInfo,
  ok,
  noProgress,
  future,
  opened,
  closed,
}

class Task extends Statusable {
  Task({
    super.id,
    required super.title,
    required super.closed,
    required this.parent,
    required this.tasks,
    this.description = '',
    this.createdOn,
    this.updatedOn,
    this.dueDate,
    this.startDate,
    this.closedDate,
    this.workspaceId,
    this.status,
    this.priority,
    this.author,
    this.assignee,
    this.taskSource,
    this.type,
  });

  List<Task> tasks;
  final String description;

  final DateTime? createdOn;
  final DateTime? updatedOn;
  DateTime? startDate;
  DateTime? closedDate;
  final DateTime? dueDate;
  final int? workspaceId;
  final Status? status;
  final Priority? priority;
  final Person? author;
  final Person? assignee;
  final TaskSource? taskSource;
  final TaskType? type;
  Task? parent;

  TaskLevel level = TaskLevel.workspace;

  Iterable<Task> allTasks = [];
  Iterable<Task> openedSubtasks = [];
  Iterable<Task> closedSubtasks = [];
  Iterable<Task> leafTasks = [];
  Iterable<Task> openedLeafTasks = [];
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

  double? velocity;
  double? targetVelocity;
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
