// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../main.dart';
import '../../../components/mt_alert_dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type_presenter.dart';

class DeleteController {
  Future delete(Task task) async {
    final confirm = await showMTAlertDialog(
      task.deleteDialogTitle,
      description: '${task.isLeaf ? '' : '${loc.task_delete_dialog_description}\n'}${loc.delete_dialog_description}',
      actions: [
        MTADialogAction(title: loc.yes, type: MTActionType.isDanger, result: true),
        MTADialogAction(title: loc.no, type: MTActionType.isDefault, result: false),
      ],
      simple: true,
    );
    if (confirm == true) {
      task.loading = true;
      mainController.refresh();

      Navigator.of(rootKey.currentContext!).pop();
      if (await taskUC.delete(task.ws, task)) {
        if (task.parent != null) {
          task.parent!.tasks.remove(task);
        }
        mainController.allTasks.remove(task);
      }

      task.loading = false;
      mainController.refresh();
    }
  }
}
