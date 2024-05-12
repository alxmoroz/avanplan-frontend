// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_transfer.dart';
import '../../../usecases/task_tree.dart';
import '../controllers/task_controller.dart';
import '../widgets/local_transfer/task_selector.dart';
import 'edit.dart';

extension LocalExportUC on TaskController {
  /// перенос в другую цель, проект

  Future localExport() async {
    final sourceTaskId = task.parentId;
    final destination = await selectTask(
      task.targetsForLocalExport,
      loc.task_transfer_destination_hint,
    );

    if (destination != null) {
      // Перенос между проектами или РП
      if (destination.project.id != task.project.id || destination.wsId != task.wsId) {
        router.pop();

        await move(destination);
      }
      // внутри одного проекта
      else {
        // новый родитель
        task.parentId = destination.id;
        if (!await saveField(TaskFCode.parent)) {
          task.parentId = sourceTaskId;
          tasksMainController.refreshTasksUI();
        }
      }
    }
  }
}
