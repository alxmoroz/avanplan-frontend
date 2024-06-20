// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../components/constants.dart';
import '../components/text.dart';
import '../extra/services.dart';
import '../usecases/project_module.dart';
import '../usecases/task_tree.dart';
import 'workspace.dart';

String addSubtaskActionTitle(Task? parent) {
  final taskTitle = loc.task_plural_accusative(1);
  final objTitle = {
        'ROOT': loc.project_plural(1),
        TType.PROJECT: parent?.hmGoals == true ? loc.goal_plural_accusative(1) : taskTitle,
        TType.INBOX: taskTitle,
        TType.GOAL: taskTitle,
        TType.BACKLOG: taskTitle,
      }[parent?.type ?? 'ROOT'] ??
      loc.subtask_plural_accusative(1);
  return '${loc.action_add_title} $objTitle';
}

String newSubtaskTitle(Task? parent) =>
    {
      'ROOT': loc.project_new_title,
      TType.PROJECT: parent?.hmGoals == true ? loc.goal_new_title : loc.task_new_title,
      TType.INBOX: loc.task_new_title,
      TType.GOAL: loc.task_new_title,
      TType.BACKLOG: loc.task_new_title,
    }[parent?.type ?? 'ROOT'] ??
    loc.subtask_new_title;

extension TaskTypePresenter on Task {
  String get _typeName =>
      {
        TType.PROJECT: loc.project_title,
        TType.INBOX: loc.inbox,
        TType.GOAL: loc.goal_title,
        TType.TASK: loc.task_title,
        TType.BACKLOG: loc.backlog,
      }[type] ??
      loc.subtask_title;

  String get viewTitle => '$_typeName ${isNew ? '' : '#$id'}';

  String get listTitle =>
      {
        TType.PROJECT: hmGoals ? loc.goal_list_title : loc.task_list_title,
        TType.GOAL: loc.task_list_title,
        TType.BACKLOG: loc.task_list_title,
        TType.TASK: loc.checklist,
      }[type] ??
      loc.subtask_list_title;

  String get deleteDialogTitle =>
      {
        TType.PROJECT: loc.project_delete_dialog_title,
        TType.GOAL: loc.goal_delete_dialog_title,
        TType.TASK: loc.task_delete_dialog_title,
        TType.BACKLOG: loc.task_delete_dialog_title,
      }[type] ??
      loc.subtask_delete_dialog_title;

  String dativeSubtasksCount(int count) =>
      {
        TType.PROJECT: hmGoals ? loc.goal_count_dative(count) : loc.task_count_dative(count),
        TType.INBOX: loc.task_count_dative(count),
        TType.GOAL: loc.task_count_dative(count),
        TType.BACKLOG: loc.task_count_dative(count),
      }[type] ??
      loc.subtask_count_dative(count);

  String subtasksCountStr(int count) =>
      {
        TType.PROJECT: hmGoals ? loc.goal_count(count) : loc.task_count(count),
        TType.INBOX: loc.task_count(count),
        TType.GOAL: loc.task_count(count),
        TType.BACKLOG: loc.task_count(count),
      }[type] ??
      loc.subtask_count(count);

  Widget subPageTitle(String pageTitle) => SizedBox(
        height: P8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SmallText('$this', align: TextAlign.center, maxLines: 1, padding: const EdgeInsets.symmetric(horizontal: P3)),
            H3(pageTitle, align: TextAlign.center, maxLines: 1, padding: const EdgeInsets.symmetric(horizontal: P3)),
          ],
        ),
      );

  String get wsCode => isProject ? ws.codeStr : '';
}
