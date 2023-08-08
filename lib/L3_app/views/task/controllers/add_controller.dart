// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../L1_domain/entities_extensions/task_status_ext.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type_presenter.dart';
import '../../../usecases/ws_available_actions.dart';
import '../../tariff/tariff_select_view.dart';
import 'task_controller.dart';

class AddController {
  AddController(this.ws, this.parentTaskController);
  final Workspace ws;
  final TaskController? parentTaskController;

  Task? get parent => parentTaskController?.task;
  bool get newProject => parent == null;
  bool get newGoal => parent!.isProject;

  String get titlePlaceholder => newSubtaskTitle(parent?.type ?? TType.ROOT);
  bool get plCreate => newProject ? ws.plProjects : ws.plTasks;

  Future addSubtask() async {
    if (plCreate) {
      final newTaskData = Task(
        title: titlePlaceholder,
        statusId: (newProject || newGoal) ? null : parent!.statuses.firstOrNull?.id,
        closed: false,
        parent: parent,
        tasks: [],
        members: [],
        notes: [],
        projectStatuses: [],
        ws: ws,
        startDate: DateTime.now(),
        createdOn: DateTime.now(),
        type: newProject
            ? TType.PROJECT
            : newGoal
                ? TType.GOAL
                : parent!.isGoal
                    ? TType.TASK
                    : TType.SUBTASK,
      );

      await mainController.showTask(newTaskData);
      if (parentTaskController != null) {
        parentTaskController!.selectTab(TaskTabKey.subtasks);
      }
    } else {
      await changeTariff(
        ws,
        reason: newProject ? loc.tariff_change_limit_projects_reason_title : loc.tariff_change_limit_tasks_reason_title,
      );
    }
  }
}
