// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_level.dart';
import 'task_comparators.dart';

extension TaskFilterPresenter on Task {
  List<Task> get sortedSubtasks => tasks.sorted(sortByDateAsc);

  List<MapEntry<TaskState, List<Task>>> get subtaskGroups {
    final groupedTasks = groupBy<Task, TaskState>(sortedSubtasks, (t) => t.overallState);
    return groupedTasks.entries.sorted((g1, g2) => g1.key.index.compareTo(g2.key.index));
  }

  List<Task> get attentionalTasks => subtaskGroups.isNotEmpty &&
          (isWorkspace ||
              [
                TaskState.overdue,
                TaskState.risk,
                TaskState.ok,
              ].contains(subtaskGroups.first.key))
      ? subtaskGroups.first.value
      : [];
}
