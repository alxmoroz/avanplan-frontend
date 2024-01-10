// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../L1_domain/entities/project_status.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../main.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/board/dd_item.dart';
import '../../../components/board/dd_item_target.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/select_dialog.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_actions.dart';
import '../../../usecases/task_edit.dart';
import '../../../usecases/task_status.dart';
import '../../../usecases/task_tree.dart';
import '../widgets/tasks/task_card.dart';
import 'task_controller.dart';

class StatusController {
  StatusController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task!;

  Future<bool?> _closeDialog() async => await showMTAlertDialog(
        loc.close_dialog_recursive_title,
        description: loc.close_dialog_recursive_description,
        actions: [
          MTADialogAction(title: loc.close_w_subtasks, type: MTActionType.isWarning, result: true),
          MTADialogAction(title: loc.cancel, type: MTActionType.isDefault, result: false),
        ],
      );

  Future setStatus(Task t, {int? stId, bool? close}) async {
    if (stId != null || close != null) {
      stId ??= t.canSetStatus ? (close == true ? t.firstClosedStatusId : t.firstOpenedStatusId) : null;
      close ??= t.statusForId(stId)?.closed;

      if (close == true && t.hasOpenedSubtasks) {
        if (await _closeDialog() == true) {
          // TODO: перенести на бэк (есть задача такая)
          for (Task st in t.subtasks.where((t) => t.closed != close)) {
            st.projectStatusId = t.projectStatusId;
            st.setClosed(close);
            await taskUC.save(t);
          }
        } else {
          return;
        }
      }

      final oldStId = t.projectStatusId;
      final oldClosed = t.closed;
      final oldClosedDate = t.closedDate;

      t.projectStatusId = stId;
      t.setClosed(close);

      final sameTask = t == task;
      final saved = sameTask ? await _taskController.saveField(TaskFCode.status) : (await t.save() != null);

      if (!saved) {
        t.projectStatusId = oldStId;
        t.closed = oldClosed;
        t.closedDate = oldClosedDate;
        tasksMainController.refreshTasks();
      } else {
        //TODO: может неожиданно для пользователя вываливаться в случае редактирования статуса закрытой задачи
        if (sameTask && t.closed && !t.isCheckItem) {
          Navigator.of(rootKey.currentContext!).pop();
        }
      }
    }
  }

  Future selectStatus() async {
    final selectedStatus = await showMTSelectDialog<ProjectStatus>(
      task.statuses.toList(),
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

    if (selectedStatus != null) {
      await setStatus(task, stId: selectedStatus.id);
    }
  }

  Future moveTask(int oldTaskIndex, int oldStatusIndex, int newTaskIndex, int newStatusIndex) async {
    if (oldStatusIndex != newStatusIndex) {
      final oldStatusId = task.statuses.elementAt(oldStatusIndex).id!;
      final newStatusId = task.statuses.elementAt(newStatusIndex).id!;

      final t = task.subtasksForStatus(oldStatusId)[oldTaskIndex];
      await setStatus(t, stId: newStatusId);
    }
  }

  bool canMoveTaskTarget(MTDragNDropItem? incoming, MTDragNDropItemTarget target) {
    // final incomingTask = (incoming?.child as TaskCard).task;
    // final targetColumn = target.parent as MTBoardColumn;
    // return incomingTask.status != targetColumn.status;
    HapticFeedback.selectionClick();
    return true;
  }

  bool canMoveTask(MTDragNDropItem? incoming, MTDragNDropItem target) {
    final incomingTask = (incoming?.child as TaskCard).task;
    final targetTask = (target.child as TaskCard).task;
    // return incomingTask.status != targetTask.status;
    if (incomingTask != targetTask) {
      HapticFeedback.selectionClick();
    }

    return true;
  }
}
