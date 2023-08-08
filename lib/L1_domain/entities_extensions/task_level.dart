// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';
import '../entities/task_source.dart';
import 'task_stats.dart';

extension TaskLevelExtension on Task {
  bool get isProject => type == TType.PROJECT || parent == null;
  bool get isGoal => type == TType.GOAL;
  bool get isTask => type == TType.TASK;
  bool get isSubtask => type == TType.SUBTASK;

  bool get hasSubtasks => tasks.isNotEmpty;
  bool get isLeaf => (isTask || isSubtask) && !hasSubtasks;

  Task? get project {
    if (isProject) {
      return this;
    } else if (parent != null) {
      return parent!.project;
    }
    return null;
  }

  Iterable<Task> get allTasks {
    final res = <Task>[];
    for (Task t in tasks) {
      res.addAll(t.allTasks);
      res.add(t);
    }
    return res;
  }

  Iterable<TaskSource> allTaskSources() {
    final tss = <TaskSource>[];
    for (Task subtask in tasks) {
      tss.addAll(subtask.allTaskSources());
    }
    if (linked) {
      tss.add(taskSource!);
    }
    return tss;
  }
}
