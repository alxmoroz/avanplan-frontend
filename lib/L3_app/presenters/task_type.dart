// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../components/text.dart';
import '../extra/services.dart';

String newSubtaskTitle(Task? parent) =>
    {
      TType.ROOT: loc.project_new_title,
      // TType.PROJECT: parent?.hfsGoals == true ? loc.goal_new_title : loc.task_new_title,
      TType.PROJECT: loc.goal_new_title,
      TType.GOAL: loc.task_new_title,
    }[parent?.type ?? TType.ROOT] ??
    loc.subtask_new_title;

extension TaskTypePresenter on Task {
  String get _typeName =>
      {
        TType.ROOT: loc.workspace_title,
        TType.PROJECT: loc.project_title,
        TType.GOAL: loc.goal_title,
        TType.TASK: loc.task_title,
      }[type] ??
      loc.subtask_title;

  String get viewTitle => '$_typeName ${isNew ? '' : '#$id'}';

  String get listTitle =>
      {
        TType.ROOT: loc.project_list_title,
        // TType.PROJECT: hfsGoals ? loc.goal_list_title : loc.task_list_title,
        TType.PROJECT: loc.goal_list_title,
        TType.GOAL: loc.task_list_title,
      }[type] ??
      loc.subtask_list_title;

  String get deleteDialogTitle =>
      {
        TType.ROOT: loc.workspace_delete_dialog_title,
        TType.PROJECT: loc.project_delete_dialog_title,
        TType.GOAL: loc.goal_delete_dialog_title,
        TType.TASK: loc.task_delete_dialog_title,
      }[type] ??
      loc.subtask_delete_dialog_title;

  String dativeSubtasksCount(int count) =>
      {
        TType.ROOT: loc.project_count_dative(count),
        TType.PROJECT: loc.goal_count_dative(count),
        TType.GOAL: loc.task_count_dative(count),
        TType.TASK: loc.subtask_count_dative(count),
      }[type] ??
      loc.subtask_count_dative(count);

  String subtasksCount(int count) =>
      {
        TType.ROOT: loc.project_count(count),
        TType.PROJECT: loc.goal_count(count),
        TType.GOAL: loc.task_count(count),
        TType.TASK: loc.subtask_count(count),
      }[type] ??
      loc.subtask_count(count);

  Widget subPageTitle(String pageTitle) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BaseText.medium(pageTitle),
          BaseText('$this'),
        ],
      );

  String get wsCode => isProject && mainController.workspaces.length > 1 ? '[${ws.code}] ' : '';
}
