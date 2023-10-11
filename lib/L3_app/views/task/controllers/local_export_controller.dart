// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_comparators.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_transfer.dart';
import '../widgets/transfer/select_task_dialog.dart';
import 'task_controller.dart';

class LocalExportController {
  LocalExportController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task;

  /// перенос в другую цель

  Future localExport() async {
    final sourceGoalId = task.parentId;
    final destinationGoalId = await selectTaskDialog(
      task.goalsForLocalExport.sorted(sortByDateAsc),
      loc.task_transfer_destination_hint,
    );

    if (destinationGoalId != null) {
      task.parentId = destinationGoalId;
      if (!(await _taskController.saveField(TaskFCode.parent))) {
        task.parentId = sourceGoalId;
      } else {
        tasksMainController.refreshTasks();
      }
    }
  }
}
