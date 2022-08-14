// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../extra/services.dart';

enum TaskLevel { workspace, project, goal, task, subtask }

extension TaskLevelPresenter on Task {
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

  String get _levelName =>
      {
        TaskLevel.workspace: loc.workspace_title,
        TaskLevel.project: loc.project_title,
        TaskLevel.goal: loc.goal_title,
        TaskLevel.task: loc.task_title,
      }[level] ??
      loc.subtask_title;

  String get viewTitle => '$_levelName #$id';

  String get listTitle =>
      {
        TaskLevel.workspace: loc.project_list_title,
        TaskLevel.project: loc.goal_list_title,
        TaskLevel.goal: loc.task_list_title,
      }[level] ??
      loc.subtask_list_title;

  String get newSubtaskTitle =>
      {
        TaskLevel.workspace: loc.project_new_title,
        TaskLevel.project: loc.goal_new_title,
        TaskLevel.goal: loc.task_new_title,
      }[level] ??
      loc.subtask_new_title;

  String get noSubtasksTitle =>
      {
        TaskLevel.workspace: loc.project_list_empty_title,
        TaskLevel.project: loc.goal_list_empty_title,
        TaskLevel.goal: loc.task_list_empty_title,
      }[level] ??
      loc.subtask_list_empty_title;
}
