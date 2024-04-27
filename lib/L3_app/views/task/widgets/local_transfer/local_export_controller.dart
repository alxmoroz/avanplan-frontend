// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../../L1_domain/entities/task.dart';
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

  Future localExport(BuildContext context) async {
    final sourceTaskId = task.parentId;
    final destination = await selectTask(
      task.targetsForLocalExport,
      loc.task_transfer_destination_hint,
    );

    if (destination != null) {
      // Перенос между проектами или РП
      if (destination.project.id != task.project.id || destination.wsId != task.wsId) {
        if (context.mounted) context.pop();

        await task.move(destination);
      }
      // внутри одного проекта
      else {
        // новый родитель
        task.parentId = destination.id;
        if (!await _taskController.saveField(TaskFCode.parent)) {
          task.parentId = sourceTaskId;
          tasksMainController.refreshTasksUI();
        }
      }
    }
  }
}
