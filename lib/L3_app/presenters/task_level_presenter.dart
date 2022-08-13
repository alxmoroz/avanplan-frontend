// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';

enum TaskLevel { project, goal, task, subtask }

extension TaskLevelPresenter on Task {
  int get _level {
    int res = 1;
    if (parent != null) {
      res += parent?._level ?? 1;
    }
    return res;
  }

  TaskLevel get level => {1: TaskLevel.project, 2: TaskLevel.goal, 3: TaskLevel.task}[_level] ?? TaskLevel.subtask;

  String get viewTitle =>
      {TaskLevel.project: loc.project_title, TaskLevel.goal: loc.goal_title, TaskLevel.task: loc.task_title}[level] ?? loc.subtask_title;
}
