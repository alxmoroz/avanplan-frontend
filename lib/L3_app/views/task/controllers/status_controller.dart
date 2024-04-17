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
import 'project_statuses_controller.dart';
import 'task_controller.dart';

class StatusController {
  StatusController(this._taskController);
  final TaskController _taskController;

  Task get _task => _taskController.task!;
  ProjectStatusesController get _psController => _taskController.projectStatusesController;

  Future<bool?> _closeTreeDialog() async => await showMTAlertDialog(
        loc.close_dialog_recursive_title,
        description: loc.close_dialog_recursive_description,
        actions: [
          MTADialogAction(title: loc.close_w_subtasks, type: MTActionType.isWarning, result: true),
          MTADialogAction(title: loc.cancel, type: MTActionType.isDefault, result: false),
        ],
      );

  // TODO: перенести часть логики на бэк (есть задача такая). Здесь оставить только проход по дереву в памяти без вызова апи
  // TODO: будет единый код ответа по возможным ошибкам при обходе дерева

  Future _setTaskTreeStatus(Task t, {int? stId, bool? closed}) async {
    stId ??= t.canSetStatus ? (closed == true ? _psController.firstClosedStatusId : _psController.firstOpenedStatusId) : null;
    closed ??= t.statusForId(stId)?.closed;

    final oldStId = t.projectStatusId;
    final oldClosed = t.closed;
    final oldClosedDate = t.closedDate;

    t.projectStatusId = stId;
    t.setClosed(closed);

    if (await t.save() != null) {
      t.projectStatusId = oldStId;
      t.closed = oldClosed;
      t.closedDate = oldClosedDate;
    }

    // рекурсивно закрываем по дереву
    if (closed == true) {
      for (Task subtask in t.subtasks.where((t) => !t.closed)) {
        _setTaskTreeStatus(subtask, closed: true);
      }
    }
  }

  Future _setStatus(Task t, {int? stId, bool? closed}) async {
    if (closed == true && t.hasOpenedSubtasks && await _closeTreeDialog() != true) {
      return;
    }
    _setTaskTreeStatus(t, stId: stId, closed: closed);
    tasksMainController.refreshTasksUI();

    //TODO: может неожиданно для пользователя вываливаться в случае редактирования статуса закрытой задачи
    final isRoot = t == _task;
    if (isRoot && t.closed && !t.isCheckItem) {
      Navigator.of(rootKey.currentContext!).pop();
    }
  }

  Future setClosed(bool closed) async => await _setStatus(_task, closed: closed);

  Future selectStatus() async {
    final selectedStatus = await showMTSelectDialog<ProjectStatus>(
      _psController.sortedStatuses,
      _task.projectStatusId,
      loc.task_status_select_placeholder,
      valueBuilder: (_, status) {
        final selected = _task.projectStatusId == status.id;
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
      await _setStatus(_task, stId: selectedStatus.id);
    }
  }

  Future moveTask(int oldTaskIndex, int oldStatusIndex, int newTaskIndex, int newStatusIndex) async {
    if (oldStatusIndex != newStatusIndex) {
      final oldStatusId = _psController.sortedStatuses.elementAt(oldStatusIndex).id!;
      final newStatusId = _psController.sortedStatuses.elementAt(newStatusIndex).id!;

      final t = _task.subtasksForStatus(oldStatusId)[oldTaskIndex];
      await _setStatus(t, stId: newStatusId);
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
