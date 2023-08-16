// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';

extension TaskTree on Task {
  bool get isProject => type == TType.PROJECT || parentId == null;
  bool get isGoal => type == TType.GOAL;
  bool get isGroup => type == TType.GROUP;
  bool get isTask => type == TType.TASK;
  bool get isLeaf => isTask;

  Task? get parent => mainController.allTasks.firstWhereOrNull((t) => t.id == parentId);

  Task? get project {
    if (isProject) {
      return this;
    } else if (parentId != null) {
      return parent!.project;
    }
    return null;
  }

  // TODO: попробовать вынести в computed в один из контроллеров
  Iterable<Task> get subtasks => mainController.allTasks.where((t) => t.parentId == id);

  Iterable<Task> get openedSubtasks => subtasks.where((t) => !t.closed);
  Iterable<Task> get closedSubtasks => subtasks.where((t) => t.closed);

  bool get hasOpenedSubtasks => openedSubtasks.isNotEmpty;
}
