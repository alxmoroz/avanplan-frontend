// Copyright (c) 2022. Alexandr Moroz

import '../entities/task.dart';

extension TaskLevelExtension on Task {
  bool get isWorkspace => level == TaskLevel.workspace;
  bool get isProject => level == TaskLevel.project;
  bool get isGoal => level == TaskLevel.goal;
  bool get isTask => level == TaskLevel.task;
  bool get isSubtask => level == TaskLevel.subtask;

  Task? get project {
    if (isProject) {
      return this;
    } else if (parent != null) {
      return parent!.project;
    }
    return null;
  }

  void updateLevel() {
    level = {
          1: TaskLevel.workspace,
          2: TaskLevel.project,
          3: TaskLevel.goal,
          4: TaskLevel.task,
        }[_numLevel] ??
        TaskLevel.subtask;
  }

  int get _numLevel {
    int res = 1;
    if (parent != null) {
      res += parent?._numLevel ?? 1;
    }
    return res;
  }
}
