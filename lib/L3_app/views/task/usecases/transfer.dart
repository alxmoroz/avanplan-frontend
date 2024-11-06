// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../components/dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../controllers/task_controller.dart';
import '../widgets/tasks/tasks_selector_controller.dart';
import '../widgets/tasks/tasks_selector_dialog.dart';
import '../widgets/transfer/transfer_unlink_relations_confirm_dialog.dart';
import 'edit.dart';

extension LocalTransferUC on TaskController {
  // перенос в другую цель, проект
  Future localExport() async {
    final src = task;
    final tsc = TasksSelectorController();
    tsc.load(() async {
      final tasks = <Task>[];
      for (Workspace ws in wsMainController.workspaces) {
        tasks.addAll(await wsTransferUC.destinationsForMove(ws.id!, src.type));
      }
      tasks.removeWhere((t) => t.wsId == src.parent?.wsId && t.id == src.parentId);
      tasks.sort();
      tsc.setTasks(tasks);
    });

    final dst = await showMTDialog<Task>(TasksSelectorDialog(
      tsc,
      loc.transfer_select_destination_hint,
      loc.transfer_export_empty_title,
    ));

    // TODO: проверяем баланс в РП назначения. Хотя, в исходном тоже надо бы проверять...
    if (dst != null &&
        await dst.ws.checkBalance(loc.action_transfer_title) &&
        (src.relations.isEmpty || dst.wsId == src.wsId || await confirmTransferAndUnlinkRelations)) {
      await move(dst);
    }
  }
}
