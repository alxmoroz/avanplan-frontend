// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../extra/services.dart';
import '../presenters/task_state.dart';

List<MapEntry<TaskState, List<Task>>> groups(Iterable<Task> tasks) {
  final gt = groupBy<Task, TaskState>(tasks, (t) => t.overallState);
  return gt.entries.sortedBy<num>((g) => g.key.index);
}

extension TaskTreeUC on Task {
  Task? get parent => tasksMainController.allTasks.firstWhereOrNull((t) => t.id == parentId);

  // TODO: что за ситуация такая, когда нет проекта?
  Task? get project {
    if (isProject) {
      return this;
    } else if (parentId != null && parent != null) {
      return parent!.project;
    }
    return null;
  }

  // TODO: попробовать вынести в computed в один из контроллеров
  Iterable<Task> get subtasks => tasksMainController.allTasks.where((t) => t.parentId == id);

  Iterable<Task> get openedSubtasks => subtasks.where((t) => !t.closed);
  Iterable<Task> get closedSubtasks => subtasks.where((t) => t.closed);

  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;

  List<Task> subtasksForStatus(int statusId) => subtasks.where((t) => t.projectStatusId == statusId).toList();
  List<MapEntry<TaskState, List<Task>>> get subtaskGroups => groups(subtasks);

  Workspace get ws => wsMainController.wsForId(wsId);
}
