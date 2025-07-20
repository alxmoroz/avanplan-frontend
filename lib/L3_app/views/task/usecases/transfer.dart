// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/workspace.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../../app/services.dart';
import '../controllers/task_controller.dart';
import '../widgets/tasks/tasks_selector_controller.dart';
import '../widgets/tasks/tasks_selector_dialog.dart';
import '../widgets/transfer/transfer_unlink_relations_confirm_dialog.dart';
import 'edit.dart';

Future<Task?> selectTaskNewParent({
  TType srcType = TType.TASK,
  int? srcWsId,
  int? srcParentId,
  String pageTitle = '',
  String emptyText = '',
}) async {
  final tsc = TasksSelectorController();
  tsc.load(() async {
    final tasks = <Task>[];
    for (Workspace ws in wsMainController.workspaces) {
      tasks.addAll(await wsTransferUC.destinationsForMove(ws.id!, srcType));
    }
    tasks.removeWhere((t) => t.wsId == srcWsId && t.id == srcParentId);
    tasks.sort();
    tsc.setTasks(tasks);
  });

  final newParent = await TasksSelectorDialog.show(tsc, pageTitle, emptyText);

  // TODO: проверяем баланс в РП назначения. Хотя, в исходном тоже надо бы проверять...
  if (newParent != null && await newParent.ws.checkBalance(loc.action_transfer_title)) {
    return newParent;
  } else {
    return null;
  }
}

extension LocalTransferUC on TaskController {
  // перенос в другую цель, проект
  Future localExport() async {
    final src = task;
    final srcWsId = src.wsId;
    final parent = await selectTaskNewParent(
      srcType: src.type,
      srcWsId: srcWsId,
      srcParentId: src.parentId,
      pageTitle: loc.transfer_select_destination_hint,
      emptyText: loc.transfer_export_empty_title,
    );
    if (parent != null && (src.relations.isEmpty || parent.wsId == srcWsId || await confirmTransferAndUnlinkRelations)) {
      await move(parent);
    }
  }
}
