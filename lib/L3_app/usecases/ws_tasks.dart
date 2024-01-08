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
  Future<Task?> createTask(Task? _parent, {int? statusId}) async {
    final _newProject = _parent == null;
    final _newGoal = _parent != null && _parent.isProject && _parent.hfsGoals;
    final _newCheckItem = _parent != null && _parent.isTask;

    if (!plCreate(_parent)) {
      await changeTariff(
        reason: _newProject ? loc.tariff_change_limit_projects_reason_title : loc.tariff_change_limit_tasks_reason_title,
      );
    }

    Task? newTask;

    if (plCreate(_parent)) {
      final taskData = Task(
        title: newSubtaskTitle(_parent),
        projectStatusId: statusId ?? ((_newProject || _newGoal) ? null : _parent.statuses.firstOrNull?.id),
        closed: false,
        parentId: _parent?.id,
        members: [],
        notes: [],
        attachments: [],
        projectStatuses: [],
        projectFeatureSets: [],
        wsId: id!,
        startDate: DateTime.now(),
        createdOn: DateTime.now(),
        type: _newProject
            ? TType.PROJECT
            : _newGoal
                ? TType.GOAL
                : _newCheckItem
                    ? TType.CHECKLIST_ITEM
                    : TType.TASK,
      );

      // TODO: возможно, будет лучше в квизе это как-то обыграть...
      loader.setSaving();
      loader.start();
      newTask = await taskData.save();
      loader.stop();
    }
    return newTask;
  }
}
