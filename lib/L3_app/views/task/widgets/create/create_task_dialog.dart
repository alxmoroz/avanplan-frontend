// Copyright (c) 2024. Alexandr Moroz

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/dialog.dart';
import '../../../../extra/router.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_feature_sets.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../views/_base/loader_screen.dart';
import '../../../../views/task/controllers/task_controller.dart';
import '../../../../views/task/usecases/edit.dart';

Future<Task?> createTask(Workspace ws, Task? parent, {int? statusId}) async {
  Task? newTask;

  if (await ws.checkBalance(addSubtaskActionTitle(parent))) {
    final tc = TaskController();
    tc.setLoaderScreenSaving();

    showMTDialog(LoaderScreen(tc, isDialog: true));

    final newProject = parent == null;
    final newGoal = parent != null && parent.isProject && parent.hfsGoals;
    final newCheckItem = parent != null && parent.isTask;

    final taskData = Task(
      title: newSubtaskTitle(parent),
      projectStatusId: statusId,
      closed: false,
      parentId: parent?.id,
      members: [],
      notes: [],
      attachments: [],
      projectStatuses: [],
      projectFeatureSets: [],
      wsId: ws.id!,
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
    tc.initWithTask(taskData);
    newTask = await tc.save();
    newTask?.creating = true;
    newTask?.filled = true;
    router.pop();
  }
  return newTask;
}
