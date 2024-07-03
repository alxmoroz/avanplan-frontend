// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/button.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension DeleteUC on TaskController {
  Future delete() async {
    bool res = false;
    if (task.isCheckItem ||
        await showMTAlertDialog(
              task.deleteDialogTitle,
              description: '${taskDescriptor.isTask ? '' : '${loc.task_delete_dialog_description}\n'}${loc.delete_dialog_description}',
              actions: [
                MTDialogAction(title: loc.yes, type: ButtonType.danger, result: true),
                MTDialogAction(title: loc.no, result: false),
              ],
            ) ==
            true) {
      if (!task.isCheckItem) router.pop();
      await editWrapper(() async {
        final changes = await taskUC.delete(taskDescriptor);
        if (changes != null) {
          tasksMainController.setTasks(changes.affected);
          tasksMainController.removeTask(task);
          res = true;
        }
      });
    }
    return res;
  }
}
