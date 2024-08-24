// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../L1_domain/entities/project_status.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/board/dd_item.dart';
import '../../../components/board/dd_item_target.dart';
import '../../../components/button.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/images.dart';
import '../../../components/select_dialog.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/task_actions.dart';
import '../../../usecases/task_status.dart';
import '../../../usecases/task_tree.dart';
import '../controllers/task_controller.dart';
import '../usecases/edit.dart';
import '../usecases/repeat.dart';
import '../widgets/tasks/task_card.dart';

extension StatusUC on TaskController {
  Future<bool?> _closeTreeDialog() async => await showMTAlertDialog(
        imageName: ImageName.save.name,
        title: task.closeDialogRecursiveTitle,
        description: loc.close_dialog_recursive_description,
        actions: [
          MTDialogAction(title: loc.action_no_dont_close_title, result: false),
          MTDialogAction(title: loc.action_yes_close_all_title, type: ButtonType.safe, result: true),
        ],
      );

  // TODO: перенести часть логики на бэк (есть задача такая). Здесь оставить только проход по дереву в памяти без вызова апи
  // TODO: будет единый код ответа по возможным ошибкам при обходе дерева

  Future _setTaskTreeStatus(Task t, {int? stId, bool? closed}) async {
    stId ??= t.canSetStatus ? (closed == true ? projectStatusesController.firstClosedStatusId : projectStatusesController.firstOpenedStatusId) : null;
    closed ??= t.statusForId(stId)?.closed;

    final oldStId = t.projectStatusId;
    final oldClosed = t.closed;
    final oldClosedDate = t.closedDate;

    t.projectStatusId = stId;
    t.setClosed(closed);

    if (await TaskController(taskIn: t).save() != null) {
      t.projectStatusId = oldStId;
      t.closed = oldClosed;
      t.closedDate = oldClosedDate;
    }

    // рекурсивно закрываем по дереву
    if (closed == true) {
      for (Task subtask in t.subtasks.where((t) => !t.closed)) {
        // тут нет await умышленно
        _setTaskTreeStatus(subtask, closed: true);
      }
    }
  }

  Future _setStatus(Task t, {int? stId, bool? closed, BuildContext? context}) async {
    if (closed == true && t.hasOpenedSubtasks && await _closeTreeDialog() != true) {
      return;
    }

    // тут нет await умышленно, чтобы можно было сначала выйти из диалога и дожидаться операции уже в списке
    _setTaskTreeStatus(t, stId: stId, closed: closed);
    // tasksMainController.refreshUI();

    // тут надо проверять контекст, чтобы понять, что был вызов из диалога, а не внутренний
    if (context != null && context.mounted && t.closed && !t.isCheckItem) {
      context.pop();
      if (t.repeat != null) {
        repeat();
      }
    }
  }

  Future setClosed(BuildContext context, bool closed) async => await _setStatus(task, closed: closed, context: context);

  Future selectStatus(BuildContext context) async {
    final selectedStatus = await showMTSelectDialog<ProjectStatus>(
      projectStatusesController.sortedStatuses,
      task.projectStatusId,
      loc.task_status_select_placeholder,
      valueBuilder: (_, status) {
        final selected = task.projectStatusId == status.id;
        final closed = status.closed;
        final text = '$status';
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected && !closed) const SizedBox(width: P2),
            if (closed) ...[const DoneIcon(true, color: f2Color), const SizedBox(width: P)],
            Flexible(child: selected ? H3(text, maxLines: 1) : BaseText(text, maxLines: 1)),
            if (closed) SizedBox(width: P3 - (selected ? P2 : 0)),
          ],
        );
      },
    );

    if (selectedStatus != null && selectedStatus.id != null) {
      _setStatus(task, stId: selectedStatus.id, context: context.mounted ? context : null);
    }
  }

  Future changeStatus(int oldTaskIndex, int oldStatusIndex, int newTaskIndex, int newStatusIndex) async {
    if (oldStatusIndex != newStatusIndex) {
      final oldStatusId = projectStatusesController.sortedStatuses.elementAt(oldStatusIndex).id!;
      final newStatusId = projectStatusesController.sortedStatuses.elementAt(newStatusIndex).id!;

      final t = task.subtasksForStatus(oldStatusId)[oldTaskIndex];
      await _setStatus(t, stId: newStatusId);
    }
  }

  bool itemTargetOnWillAccept(MTDragNDropItem? incoming, MTDragNDropItemTarget target) {
    // final incomingTask = (incoming?.child as TaskCard).task;
    // final targetColumn = target.parent as MTBoardColumn;
    // return incomingTask.status != targetColumn.status;
    HapticFeedback.selectionClick();
    return true;
  }

  bool itemOnWillAccept(MTDragNDropItem? incoming, MTDragNDropItem target) {
    final incomingTask = (incoming?.child as TaskCard).task;
    final targetTask = (target.child as TaskCard).task;
    // return incomingTask.status != targetTask.status;
    if (incomingTask != targetTask) {
      HapticFeedback.selectionClick();
    }
    return true;
  }
}
