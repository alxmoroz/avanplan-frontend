// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_transfer.dart';
import '../../../../usecases/task_edit.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import 'task_selector.dart';

class LocalExportController {
  LocalExportController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task!;

  /// перенос в другую цель, проект

  Future localExport() async {
    final sourceTaskId = task.parentId;
    final destination = await selectTask(
      task.targetsForLocalExport,
      loc.task_transfer_destination_hint,
    );

    if (destination != null) {
      bool ok = false;
      // Перенос между РП
      if (destination.wsId != task.wsId) {
        final movedTask = await task.move(destination);
        if (movedTask != null) {
          ok = true;
          task.id = movedTask.id;
          task.wsId = movedTask.wsId;
        }
      }
      // внутри одного РП
      else {
        // новый родитель
        task.parentId = destination.id;

        // TODO: перенести логику на бэк (в трансфер-контроллере это уже сделано)
        // выставлять статус по умолчанию (или сбрасывать) при переносе, если перенос из другого проекта
        final oldStId = task.projectStatusId;
        if (task.isTask && destination.project?.id != task.project?.id) {
          task.projectStatusId = TaskController(destination).projectStatusesController.firstOpenedStatusId;
        }

        ok = await _taskController.saveField(TaskFCode.parent);
        if (!ok) {
          task.parentId = sourceTaskId;
          task.projectStatusId = oldStId;
        }
      }

      if (ok) {
        tasksMainController.refreshTasks();
      }
    }
  }
}
