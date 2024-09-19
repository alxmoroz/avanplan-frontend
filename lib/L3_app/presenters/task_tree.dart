// Copyright (c) 2024. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_view_settings.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/task_members.dart';
import '../../L1_domain/entities_extensions/task_position.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../extra/services.dart';
import 'project_module.dart';
import 'task_state.dart';

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

  List<Task> _filteredSubtasksTree(Iterable<TaskViewFilter> filters) {
    final taskTree = <Task>[];
    for (Task st in subtasks) {
      if (st.isTask) {
        bool pass = false;
        for (TaskViewFilter f in filters) {
          if (f.isAssignee) {
            pass = f.values.contains(st.assigneeId);
          }
        }
        if (pass) {
          taskTree.add(st);
        }
      } else if (st.isGroup) {
        taskTree.addAll(st._filteredSubtasksTree(filters));
      }
    }
    return taskTree;
  }

  // считает только открытые задачи в группах
  int get subtasksCount => subtasksCountIn ?? subtasks.length;

  bool get isCheckList => isTask && subtasksCount > 0;
  bool get isInboxTask => isTask && project.isInbox;

  Iterable<Task> get openedSubtasks => subtasks.where((t) => !t.closed);
  Iterable<Task> get closedSubtasks => subtasks.where((t) => t.closed);
  int get closedSubtasksCount => closedSubtasksCountIn ?? closedSubtasks.length;

  bool get hasSubtasks => subtasksCount > 0 || closedSubtasksCount > 0;
  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;

  Iterable<Task> get filteredSubtasks => viewSettings.hasFilters ? _filteredSubtasksTree(viewSettings.filters!) : subtasks;
  List<Task> subtasksForStatus(int statusId) =>
      filteredSubtasks.where((t) => t.projectStatusId == statusId).sorted((t1, t2) => t1.compareByPosition(t2));
  List<MapEntry<TaskState, List<Task>>> get filteredSubtaskGroups => groups(filteredSubtasks);

  bool get assignedToMe => (assignee != null && assignee!.userId == accountController.me!.id) || !hmTeam;
}
