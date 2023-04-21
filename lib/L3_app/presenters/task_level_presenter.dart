// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_level.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';
import '../usecases/task_ext_actions.dart';

extension TaskLevelPresenter on Task {
  String get _levelName =>
      {
        TaskLevel.root: loc.workspace_title,
        TaskLevel.project: loc.project_title,
        TaskLevel.goal: loc.goal_title,
        TaskLevel.task: loc.task_title,
      }[level] ??
      loc.subtask_title;

  String get viewTitle => '$_levelName #$id';

  String get listTitle =>
      {
        TaskLevel.root: loc.project_list_title,
        TaskLevel.project: loc.goal_list_title,
        TaskLevel.goal: loc.task_list_title,
      }[level] ??
      loc.subtask_list_title;

  String get newSubtaskTitle =>
      {
        TaskLevel.root: loc.project_new_title,
        TaskLevel.project: loc.goal_new_title,
        TaskLevel.goal: loc.task_new_title,
      }[level] ??
      loc.subtask_new_title;

  String get deleteDialogTitle =>
      {
        TaskLevel.root: loc.workspace_delete_dialog_title,
        TaskLevel.project: loc.project_delete_dialog_title,
        TaskLevel.goal: loc.goal_delete_dialog_title,
        TaskLevel.task: loc.task_delete_dialog_title,
      }[level] ??
      loc.subtask_delete_dialog_title;

  String dativeSubtasksCount(int count) =>
      {
        TaskLevel.root: loc.project_count_dative(count),
        TaskLevel.project: loc.goal_count_dative(count),
        TaskLevel.goal: loc.task_count_dative(count),
        TaskLevel.task: loc.subtask_count_dative(count),
      }[level] ??
      loc.subtask_count_dative(count);

  String subtasksCount(int count) =>
      {
        TaskLevel.root: loc.project_count(count),
        TaskLevel.project: loc.goal_count(count),
        TaskLevel.goal: loc.task_count(count),
        TaskLevel.task: loc.subtask_count(count),
      }[level] ??
      loc.subtask_count(count);

  String grandchildrenCount(int count) =>
      {
        TaskLevel.root: loc.goal_count(count),
        TaskLevel.project: loc.task_count(count),
        TaskLevel.goal: loc.subtask_count(count),
      }[level] ??
      loc.subtask_count(count);

  Widget subPageTitle(String pageTitle) => Column(
        children: [
          MediumText(pageTitle),
          LightText('$this'),
        ],
      );

  String get wsCode => isProject && mainController.workspaces.length > 1 ? '[${ws.code}] ' : '';
}
