// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../../L1_domain/entities_extensions/task_status.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/ws_actions.dart';
import '../../../usecases/ws_tariff.dart';
import 'task_controller.dart';

class CreateController {
  CreateController(this._ws, this._parentTaskController);
  final Workspace _ws;
  final TaskController? _parentTaskController;

  Task? get parent => _parentTaskController?.task;
  bool get _newProject => parent == null;
  bool get _newGoal => parent!.isProject; // && parent!.hfsGoals;

  bool get plCreate => _newProject ? _ws.plProjects : _ws.plTasks;

  Future create() async {
    if (plCreate) {
      final newTaskData = Task(
        title: newSubtaskTitle(parent),
        statusId: (_newProject || _newGoal) ? null : parent!.statuses.firstOrNull?.id,
        closed: false,
        parentId: parent?.id,
        members: [],
        notes: [],
        projectStatuses: [],
        projectFeatureSets: [],
        ws: _ws,
        startDate: DateTime.now(),
        createdOn: DateTime.now(),
        type: _newProject
            ? TType.PROJECT
            : _newGoal
                ? TType.GOAL
                : TType.TASK,
      );

      await mainController.showTask(newTaskData);
      // TODO: забота онбординга скорее тут
      if (_parentTaskController != null) {
        _parentTaskController!.selectTab(TaskTabKey.subtasks);
      }
    } else {
      // TODO: как будет происходить предложение смены тарифа во время онбординга?
      await _ws.changeTariff(
        reason: _newProject ? loc.tariff_change_limit_projects_reason_title : loc.tariff_change_limit_tasks_reason_title,
      );
    }
  }
}
