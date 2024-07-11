// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../extra/services.dart';
import '../presenters/task_state.dart';
import 'project_module.dart';

List<MapEntry<TaskState, List<Task>>> groups(Iterable<Task> tasks) {
  final gt = groupBy<Task, TaskState>(tasks, (t) => t.overallState);
  return gt.entries.sortedBy<num>((g) => g.key.index);
}

extension TaskTreeUC on Task {
  Workspace get ws => wsMainController.ws(wsId) ?? Workspace.dummy;
  Task? get parent => tasksMainController.allTasks.firstWhereOrNull((t) => t.id == parentId && t.wsId == wsId);

  // TODO: попробовать вынести в computed в один из контроллеров
  Task get project => (isProject || isInbox) ? this : parent!.project;
  Iterable<Task> get subtasks => tasksMainController.allTasks.where((t) => t.parentId == id && t.wsId == wsId);
  int get subtasksCount => subtasksCountIn ?? subtasks.length;

  bool get isCheckList => isTask && subtasksCount > 0;
  bool get isInboxTask => isTask && project.isInbox;

  Iterable<Task> get openedSubtasks => subtasks.where((t) => !t.closed);
  Iterable<Task> get closedSubtasks => subtasks.where((t) => t.closed);

  bool get hasSubtasks => subtasks.isNotEmpty || (closedSubtasksCount ?? 0) > 0;
  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;

  List<Task> subtasksForStatus(int statusId) => subtasks.where((t) => t.projectStatusId == statusId).toList();
  List<MapEntry<TaskState, List<Task>>> get subtaskGroups => groups(subtasks);

  bool get assignedToMe => (assignee != null && assignee!.userId == accountController.me!.id) || !hmTeam;
}
