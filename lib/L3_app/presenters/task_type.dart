// Copyright (c) 2024. Alexandr Moroz

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../views/app/services.dart';
import 'task_tree.dart';
import 'workspace.dart';

String addTaskActionTitle([TType type = TType.TASK]) => '${loc.action_add_title} ${type.typeNameAccusative(1)}';

extension TaskTypeStrPresenter on TType {
  String get typeName =>
      {
        TType.PROJECT: loc.project_title,
        TType.INBOX: loc.inbox,
        TType.GOAL: loc.goal_title,
        TType.TASK: loc.task_title,
        TType.FORBIDDEN_TASK: loc.task_title,
        TType.BACKLOG: loc.backlog,
      }[this] ??
      loc.subtask_title;

  String typeNameAccusative(num count) =>
      {
        TType.PROJECT: loc.project_plural_accusative(count),
        TType.GOAL: loc.goal_plural_accusative(count),
        TType.BACKLOG: loc.backlog_plural_accusative(count),
        TType.TASK: loc.task_plural_accusative(count),
      }[this] ??
      loc.subtask_plural_accusative(count);
}

extension TaskTypePresenter on Task {
  String get viewTitle => '${type.typeName} ${isNew ? '' : '#$id'}';

  String get defaultTitle =>
      {
        TType.PROJECT: loc.project_new_title,
        TType.GOAL: loc.goal_new_title,
        TType.BACKLOG: loc.backlog_new_title,
        TType.TASK: loc.task_new_title,
      }[type] ??
      loc.subtask_new_title;

  String get deleteDialogTitle => '${loc.action_delete_title} ${type.typeNameAccusative(1)}?';

  String get closeDialogRecursiveTitle => loc.close_dialog_recursive_title(type.typeNameAccusative(1));

  String dativeSubtasksCount(int count) =>
      {
        TType.PROJECT: hasSubgroups ? loc.goal_count_dative(count) : loc.task_count_dative(count),
        TType.INBOX: loc.task_count_dative(count),
        TType.GOAL: loc.task_count_dative(count),
        TType.BACKLOG: loc.task_count_dative(count),
      }[type] ??
      loc.subtask_count_dative(count);

  String subtasksCountStr(int count) =>
      {
        TType.PROJECT: hasSubgroups ? loc.goal_count(count) : loc.task_count(count),
        TType.INBOX: loc.task_count(count),
        TType.GOAL: loc.task_count(count),
        TType.BACKLOG: loc.task_count(count),
      }[type] ??
      loc.subtask_count(count);

  String get wsCode => isProject ? ws.codeStr : '';
}
