// Copyright (c) 2022. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../../main.dart';
import '../../components/mt_alert_dialog.dart';
import '../../extra/services.dart';
import '../../presenters/task_type_presenter.dart';

class TaskDeleteController {
  /// удаление задачи

  void _popDeleted(Task task) {
    final context = rootKey.currentContext!;
    Navigator.of(context).pop();
    if (task.parent?.isProject == true && task.parent?.tasks.length == 1 && Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
  }

  Future delete(Task task) async {
    final confirm = await showMTAlertDialog(
      task.deleteDialogTitle,
      description: '${loc.task_delete_dialog_description}\n${loc.delete_dialog_description}',
      actions: [
        MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
      ],
      simple: true,
    );
    if (confirm == true) {
      loader.start();
      loader.setDeleting();
      if (await taskUC.delete(task.ws, task)) {
        _popDeleted(task);
        if (task.parent != null) {
          task.parent!.tasks.remove(task);
        } else {
          mainController.rootTasks.remove(task);
        }
        // mainController.updateRoots();
      }
      await loader.stop(300);
    }
  }
}
