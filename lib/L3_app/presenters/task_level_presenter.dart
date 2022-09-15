// Copyright (c) 2022. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_ext_level.dart';
import '../extra/services.dart';

extension TaskLevelPresenter on Task {
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

  String get deleteDialogTitle =>
      {
        TaskLevel.workspace: loc.workspace_delete_dialog_title,
        TaskLevel.project: loc.project_delete_dialog_title,
        TaskLevel.goal: loc.goal_delete_dialog_title,
        TaskLevel.task: loc.task_delete_dialog_title,
      }[level] ??
      loc.subtask_delete_dialog_title;

  String dativeSubtasksCount(int count) =>
      {
        TaskLevel.workspace: loc.project_dative_count(count),
        TaskLevel.project: loc.goal_dative_count(count),
        TaskLevel.goal: loc.task_dative_count(count),
        TaskLevel.task: loc.subtask_dative_count(count),
      }[level] ??
      loc.subtask_dative_count(count);

  String subtasksCount(int count) =>
      {
        TaskLevel.workspace: loc.project_count(count),
        TaskLevel.project: loc.goal_count(count),
        TaskLevel.goal: loc.task_count(count),
        TaskLevel.task: loc.subtask_count(count),
      }[level] ??
      loc.subtask_count(count);
}
