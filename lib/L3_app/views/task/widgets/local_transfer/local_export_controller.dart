// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_transfer.dart';
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
      // новый родитель
      task.parentId = destination.id;

      // выставлять статус по умолчанию (или сбрасывать) при переносе, если перенос из другого проекта
      final oldStId = task.projectStatusId;
      if (task.isTask && destination.project?.id != task.project?.id) {
        task.projectStatusId = TaskController(destination).projectStatusesController.firstOpenedStatusId;
      }

      if (!(await _taskController.saveField(TaskFCode.parent))) {
        task.parentId = sourceTaskId;
        task.projectStatusId = oldStId;
      } else {
        tasksMainController.refreshTasks();
      }
    }
  }
}
