// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/status.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../L1_domain/entities_extensions/task_status_ext.dart';
import '../../../../main.dart';
import '../../../components/mt_alert_dialog.dart';
import '../../../components/mt_select_dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../../usecases/task_available_actions.dart';
import 'task_controller.dart';

part 'status_controller.g.dart';

class StatusController extends _StatusControllerBase with _$StatusController {
  StatusController(TaskController _taskController) {
    taskController = _taskController;
  }
}

abstract class _StatusControllerBase with Store {
  late final TaskController taskController;

  Task get task => taskController.task;

  Future<Task?> _setStatus(Task t, {int? statusId, bool? close}) async {
    if (t.canSetStatus) {
      t.statusId = statusId;
    }

    if (close != null) {
      t.closed = close;
      if (close) {
        t.closedDate = DateTime.now();
      }
    }

    return await taskUC.save(task.ws, t);
  }

  Future<Task?> _setStatusTaskTree(
    Task _task, {
    int? statusId,
    bool? close,
    bool recursively = false,
  }) async {
    if (recursively) {
      // TODO: перенести на бэк?
      for (final t in _task.tasks.where((t) => t.closed != close)) {
        await _setStatus(t, statusId: statusId, close: close);
      }
    }
    return await _setStatus(_task, statusId: statusId, close: close);
  }

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
      bool recursively = false;

      statusId ??= close == true ? _task.firstClosedStatusId : _task.firstOpenedStatusId;
      close ??= _task.statusForId(statusId)?.closed;

      if (close == true && _task.hasOpenedSubtasks) {
        recursively = await _closeDialog() == true;
        if (!recursively) {
          return;
        }
      }

      loader.start();
      loader.setSaving();

      final editedTask = await _setStatusTaskTree(_task, statusId: statusId, close: close, recursively: recursively);
      await loader.stop();

      if (editedTask != null) {
        //TODO: может неожиданно для пользователя вываливаться в случае редактирования статуса закрытой задачи
        if (editedTask.closed && _task.id == task.id) {
          Navigator.of(rootKey.currentContext!).pop(editedTask);
        }
        mainController.refresh();
      }
    }
  }

  Future selectStatus() async {
    final selectedStatusId = await showMTSelectDialog<Status>(
      task.statuses,
      task.statusId,
      loc.task_status_placeholder,
    );

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
