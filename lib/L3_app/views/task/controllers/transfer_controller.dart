// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:collection/collection.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/usecases/task_comparators.dart';
import '../../../extra/services.dart';
import '../widgets/transfer/select_task_dialog.dart';
import 'task_controller.dart';

class TransferController {
  TransferController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task;

  /// перенос с другую цель

  Future localExport() async {
    final sourceGoal = task.parent!;
    final destinationGoalId = await selectTaskDialog(
      task.goalsForLocalExport.sorted(sortByDateAsc),
      loc.task_transfer_destination_hint,
    );

    if (destinationGoalId != null) {
      final destinationGoal = task.goalsForLocalExport.firstWhere((g) => g.id == destinationGoalId);
      task.parent = destinationGoal;
      if (!(await _taskController.saveField(TaskFCode.parent))) {
        task.parent = sourceGoal;
      } else {
        sourceGoal.tasks.removeWhere((t) => t.id == task.id);
        destinationGoal.tasks.add(task);
        mainController.refresh();
      }
    }
  }
}
