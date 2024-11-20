// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../components/dialog.dart';
import '../../../../navigation/router.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../views/_base/loader_screen.dart';
import '../../../../views/task/controllers/task_controller.dart';
import '../../../../views/task/usecases/edit.dart';

Future<TaskController?> createTask(Workspace ws, {TType type = TType.TASK, Task? parent, int? statusId}) async {
  TaskController? tc;

  if (await ws.checkBalance(addSubtaskActionTitle(parent, type: type))) {
    tc = TaskController();
    tc.setLoaderScreenSaving();

    showMTDialog(LoaderScreen(tc, isDialog: true));

    final taskData = Task(
      title: '',
      projectStatusId: statusId,
      closed: false,
      parentId: parent?.id,
      members: [],
      relations: [],
      notes: [],
      attachments: [],
      transactions: [],
      income: 0,
      expenses: 0,
      projectStatuses: [],
      projectModules: [],
      wsId: ws.id!,
      startDate: null,
      type: type,
    )..creating = true;

    taskData.title = taskData.defaultTitle;
    tc.initWithTask(taskData);
    final savedTask = await tc.save();
    if (!tc.loading && globalContext.mounted) Navigator.of(globalContext).pop();
    if (savedTask != null) {
      savedTask.creating = true;
      savedTask.filled = true;
      tc.taskDescriptor = savedTask;
    } else {
      tc = null;
    }
  }
  return tc;
}
