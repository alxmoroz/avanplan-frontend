// Copyright (c) 2022. Alexandr Moroz

import 'task.dart';

enum TaskLevel { workspace, project, goal, task, subtask }

extension TaskLevelExtension on Task {
  int get _level {
    int res = 1;
    if (parent != null) {
      res += parent?._level ?? 1;
    }
    return res;
  }

  TaskLevel get level =>
      {
        1: TaskLevel.workspace,
        2: TaskLevel.project,
        3: TaskLevel.goal,
        4: TaskLevel.task,
      }[_level] ??
      TaskLevel.subtask;

  bool get isWorkspace => level == TaskLevel.workspace;
}
