// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../main.dart';
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
      // Перенос между проектами или РП
      if (destination.project.id != task.project.id || destination.wsId != task.wsId) {
        Navigator.of(rootKey.currentContext!).pop();
        final movedTask = await task.move(destination);
        if (movedTask != null) {
          ok = true;
        }
      }
      // внутри одного проекта
      else {
        // новый родитель
        task.parentId = destination.id;
        ok = await _taskController.saveField(TaskFCode.parent);
        if (!ok) {
          task.parentId = sourceTaskId;
        }
      }

      if (ok) {
        tasksMainController.refreshTasksUI();
      }
    }
  }
}
