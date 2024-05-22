// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/dialog.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_tree.dart';
import '../controllers/task_controller.dart';
import '../widgets/transfer/transfer_selector.dart';
import '../widgets/transfer/transfer_selector_controller.dart';
import 'edit.dart';

extension LocalTransferUC on TaskController {
  Future localExport() async {
    final srcTaskId = task.parentId;

    final controller = TransferSelectorController();
    controller.getDestinationsForMove(task.type);
    final destination = await showMTDialog<Task>(TransferSelectorDialog(
      controller,
      loc.task_transfer_destination_hint,
      loc.task_transfer_export_empty_title,
    ));

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
          task.parentId = srcTaskId;
          tasksMainController.refreshTasksUI();
        }
      }
    }
  }
}
