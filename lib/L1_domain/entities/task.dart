// Copyright (c) 2022. Alexandr Moroz

import 'base_entity.dart';
import 'member.dart';
import 'note.dart';
import 'project_status.dart';
import 'task_source.dart';
import 'workspace.dart';

enum TaskLevel { root, project, goal, task, subtask }

class TaskState {
  static const String OVERDUE = 'OVERDUE';
  static const String RISK = 'RISK';
  static const String OK = 'OK';
  static const String AHEAD = 'AHEAD';
  static const String CLOSABLE = 'CLOSABLE';
  static const String FUTURE_START = 'FUTURE_START';
  static const String ETA = 'ETA';
  static const String NO_SUBTASKS = 'NO_SUBTASKS';
  static const String NO_PROGRESS = 'NO_PROGRESS';
  static const String TODAY = 'TODAY';
  static const String THIS_WEEK = 'THIS_WEEK';
  static const String FUTURE_DUE = 'FUTURE_DUE';
  static const String NO_DUE = 'NO_DUE';
  static const String NO_INFO = 'NO_INFO';
  static const String OPENED = 'OPENED';
  static const String CLOSED = 'CLOSED';
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
    required this.state,
    required this.startDate,
    this.createdOn,
    this.updatedOn,
    this.dueDate,
    this.closedDate,
    this.statusId,
    this.authorId,
    this.assigneeId,
    this.taskSource,
    this.type,
    this.estimate,
    required this.elapsedPeriod,
    this.etaPeriod,
    this.riskPeriod,
    this.isFuture = false,
    this.etaDate,
    this.showSP = false,
    this.targetVelocity,
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
  // Iterable<Task> closedLeaves;
  int closedLeavesCount;
  Iterable<Task> overdueSubtasks = [];
  Iterable<Task> riskySubtasks = [];
  Iterable<Task> okSubtasks = [];
  Iterable<Task> etaSubtasks = [];

  late Duration beforeStartPeriod;
  bool isFuture;
  Duration elapsedPeriod;
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

  final String state;
  late String subtasksState;
  late String overallState;

  static Task get dummy => Task(
      title: '',
      closed: false,
      parent: null,
      tasks: [],
      members: [],
      notes: [],
      projectStatuses: [],
      ws: Workspace.dummy,
      state: '',
      showSP: false,
      startDate: null,
      elapsedPeriod: const Duration(seconds: 0),
      isFuture: false);
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
