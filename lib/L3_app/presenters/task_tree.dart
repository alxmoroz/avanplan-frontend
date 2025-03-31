// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../views/app/services.dart';

extension TaskTreeUC on Task {
  // TODO: попробовать вынести в computed в один из контроллеров

  Workspace get ws => wsMainController.ws(wsId) ?? Workspace.dummy;
  Task? get parent => tasksMainController.allTasks.firstWhereOrNull((t) => t.id == parentId && t.wsId == wsId);
  Task get project => (isProject || isInbox) ? this : parent!.project;
  Task? get goal => isGoal ? this : parent?.goal;
  Task? get backlog => isBacklog ? this : parent?.backlog;

  Iterable<Task> get subtasks => tasksMainController.allTasks.where((t) => id != null && parentId == id && t.wsId == wsId);

  // считает только открытые задачи в группах
  int get subtasksCount => subtasksCountIn ?? subtasks.length;

  bool get isCheckList => isTask && subtasksCount > 0;
  bool get isInboxTask => isTask && project.isInbox;

  Iterable<Task> get openedSubtasks => subtasks.where((t) => !t.closed);
  Iterable<Task> get closedSubtasks => subtasks.where((t) => t.closed);
  int get closedSubtasksCount => closedSubtasksCountIn ?? closedSubtasks.length;

  bool get hasSubgroups => subtasks.any((st) => st.isGoalOrBacklog) || hasSubgroupsIn;
  bool get isProjectWithGroups => isProject && hasSubgroups;
  bool get isProjectWithoutGroups => isProject && !hasSubgroups;

  bool get hasSubtasks => subtasksCount > 0 || closedSubtasksCount > 0;
  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;

  // назначено на меня явно или в проекте нет никого или я один
  bool get assignedToMe {
    final myUserId = myAccountController.me!.id;
    bool assigned = assignee?.userId == myUserId;

    if (!assigned) {
      final activeMembers = this.activeMembers;
      assigned = activeMembers.isEmpty || (activeMembers.length == 1 && activeMembers[0].userId == myUserId);
    }

    return assigned;
  }
}
