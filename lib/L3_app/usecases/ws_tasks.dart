// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/workspace.dart';
import '../../L1_domain/entities_extensions/task_status.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../extra/services.dart';
import '../presenters/task_type.dart';
import 'task_feature_sets.dart';
import 'ws_actions.dart';
import 'ws_tariff.dart';

extension WSTasksUC on Workspace {
  Future<Task?> createTask(Task? _parent) async {
    final _newProject = _parent == null;
    final _newGoal = _parent != null && _parent.isProject && _parent.hfsGoals;

    if (!plCreate(_parent)) {
      // TODO: как будет происходить предложение смены тарифа во время онбординга?
      await changeTariff(
        reason: _newProject ? loc.tariff_change_limit_projects_reason_title : loc.tariff_change_limit_tasks_reason_title,
      );
    }
    return plCreate(_parent)
        ? Task(
            title: newSubtaskTitle(_parent),
            statusId: (_newProject || _newGoal) ? null : _parent.statuses.firstOrNull?.id,
            closed: false,
            parentId: _parent?.id,
            members: [],
            notes: [],
            projectStatuses: [],
            projectFeatureSets: [],
            ws: this,
            startDate: DateTime.now(),
            createdOn: DateTime.now(),
            type: _newProject
                ? TType.PROJECT
                : _newGoal
                    ? TType.GOAL
                    : TType.TASK,
          )
        : null;
  }
}
