// Copyright (c) 2024. Alexandr Moroz

import '../entities_extensions/task_stats.dart';
import 'attachment.dart';
import 'base_entity.dart';
import 'member.dart';
import 'note.dart';
import 'project_module.dart';
import 'project_status.dart';
import 'task_source.dart';

class TType {
  static const PROJECT = 'PROJECT';
  static const INBOX = 'INBOX';
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
  FUTURE_DATE,
  NO_DUE,
  BACKLOG,
  IMPORTING,
  CLOSED,
}

class TaskDescriptor extends Titleable {
  TaskDescriptor({
    super.id,
    required this.wsId,
    required this.type,
    super.createdOn,
    super.updatedOn,
    required super.title,
    super.description,
    this.category,
    this.icon,
  });

  final String type;
  int wsId;
  final String? category;
  final String? icon;
}

class Project extends TaskDescriptor {
  Project({
    super.id,
    required super.wsId,
    super.type = TType.PROJECT,
    super.createdOn,
    super.updatedOn,
    required super.title,
    super.description,
    super.category,
    super.icon,
  });
}

class Task extends Project {
  Task({
    super.id,
    required super.title,
    super.description,
    super.createdOn,
    super.updatedOn,
    required this.startDate,
    required this.closed,
    required this.parentId,
    required this.notes,
    required this.attachments,
    required this.members,
    required this.projectStatuses,
    required this.projectModules,
    required super.wsId,
    required super.type,
    this.taskSource,
    this.dueDate,
    this.closedDate,
    this.projectStatusId,
    this.authorId,
    this.assigneeId,
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
  Iterable<WSMember> members;
  Iterable<ProjectModule> projectModules;
  TaskSource? taskSource;

  DateTime? dueDate;
  DateTime? closedDate;
  int? projectStatusId;
  int? authorId;
  int? assigneeId;
  num? estimate;

  bool creating = false;

  @override
  int compareTo(t2) {
    int res = 0;
    t2 = t2 as Task;
    if ((hasDueDate && !closed) || (t2.hasDueDate && !t2.closed)) {
      if (!hasDueDate) {
        res = 1;
      } else if (!t2.hasDueDate) {
        res = -1;
      } else {
        res = dueDate!.compareTo(t2.dueDate!);
      }
    }

    if (res == 0) {
      res = super.compareTo(t2);
    }

    return res;
  }
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
  final Task updated;
  final Iterable<Task> affected;
}

class TaskNode {
  TaskNode(this.root, this.parents, this.subtasks);
  final Task root;
  final Iterable<Task> parents;
  final Iterable<Task> subtasks;
}
