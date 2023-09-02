// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/status.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_status.dart';
import '../../../../main.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/select_dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/task_actions.dart';
import '../../../usecases/task_edit.dart';
import 'task_controller.dart';

class StatusController {
  StatusController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task;

  Future<bool?> _closeDialog() async => await showMTAlertDialog(
        loc.close_dialog_recursive_title,
        description: loc.close_dialog_recursive_description,
        actions: [
          MTADialogAction(title: loc.close_w_subtasks, type: MTActionType.isWarning, result: true),
          MTADialogAction(title: loc.cancel, type: MTActionType.isDefault, result: false),
        ],
      );

  Future setStatus(Task _task, {int? statusId, bool? close}) async {
    if (statusId != null || close != null) {
      statusId ??= _task.canSetStatus ? (close == true ? _task.firstClosedStatusId : _task.firstOpenedStatusId) : null;
      close ??= _task.statusForId(statusId)?.closed;

      if (close == true && _task.hasOpenedSubtasks) {
        if (await _closeDialog() == true) {
          // TODO: перенести на бэк (есть задача такая)
          for (var t in _task.subtasks.where((t) => t.closed != close)) {
            t.statusId = _task.statusId;
            t.setClosed(close);
            await taskUC.save(t);
          }
        } else {
          return;
        }
      }

      final oldStId = _task.statusId;
      final oldClosed = _task.closed;
      final oldClosedDate = _task.closedDate;

      _task.statusId = statusId;
      _task.setClosed(close);

      final sameTask = _task == task;
      final saved = sameTask ? await _taskController.saveField(TaskFCode.status) : (await _task.save() != null);

      if (!saved) {
        _task.statusId = oldStId;
        _task.closed = oldClosed;
        _task.closedDate = oldClosedDate;
        mainController.refresh();
      } else {
        //TODO: может неожиданно для пользователя вываливаться в случае редактирования статуса закрытой задачи
        if (sameTask && _task.closed) {
          Navigator.of(rootKey.currentContext!).pop();
        }
      }
    }
  }

  Future selectStatus() async {
    final selectedStatusId = await showMTSelectDialog<Status>(task.statuses, task.statusId, loc.task_status_placeholder);

    if (selectedStatusId != null) {
      await setStatus(task, statusId: selectedStatusId);
    }
  }

  Future moveTask(int oldTaskIndex, int oldStatusIndex, int newTaskIndex, int newStatusIndex) async {
    if (oldStatusIndex != newStatusIndex) {
      final oldStatusId = task.statuses[oldStatusIndex].id!;
      final newStatusId = task.statuses[newStatusIndex].id!;

      final t = task.subtasksForStatus(oldStatusId)[oldTaskIndex];
      await setStatus(t, statusId: newStatusId);
    }
  }
}
