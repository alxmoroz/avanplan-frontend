// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../extra/services.dart';
import '../presenters/task_type.dart';
import '../usecases/task_edit.dart';
import '../usecases/task_status.dart';
import 'task_feature_sets.dart';
import 'ws_actions.dart';
import 'ws_tariff.dart';

extension WSTasksUC on Workspace {
  Future<Task?> createTask(Task? parent, {int? statusId}) async {
    Task? newTask;

    if (await checkBalance(addSubtaskActionTitle(parent))) {
      final newProject = parent == null;
      final newGoal = parent != null && parent.isProject && parent.hfsGoals;
      final newCheckItem = parent != null && parent.isTask;

      if (!plCreate(parent)) {
        await changeTariff(
          reason: newProject ? loc.tariff_change_limit_projects_reason_title : loc.tariff_change_limit_tasks_reason_title,
        );
      }

      if (plCreate(parent)) {
        final taskData = Task(
          title: newSubtaskTitle(parent),
          projectStatusId: statusId ?? ((newProject || newGoal) ? null : parent.statuses.firstOrNull?.id),
          closed: false,
          parentId: parent?.id,
          members: [],
          notes: [],
          attachments: [],
          projectStatuses: [],
          projectFeatureSets: [],
          wsId: id!,
          startDate: DateTime.now(),
          createdOn: DateTime.now(),
          type: newProject
              ? TType.PROJECT
              : newGoal
                  ? TType.GOAL
                  : newCheckItem
                      ? TType.CHECKLIST_ITEM
                      : TType.TASK,
        );

        // TODO: возможно, будет лучше в квизе это как-то обыграть...
        loader.setSaving();
        loader.start();
        newTask = await taskData.save();
        loader.stop();
      }
    }
    return newTask;
  }
}
