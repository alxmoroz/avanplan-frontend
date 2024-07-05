// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/button.dart';
import '../../../components/images.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_type.dart';
import '../../../usecases/task_tree.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension DeleteUC on TaskController {
  Future delete() async {
    final hasSubtasks = task.hasSubtasks;
    bool res = false;
    if (task.isCheckItem ||
        await showMTAlertDialog(
              task.hasSubtasks ? loc.task_delete_dialog_group_title : task.deleteDialogTitle,
              imageName: ImageName.delete.name,
              description: loc.delete_dialog_description,
              actions: [
                MTDialogAction(
                  title: hasSubtasks ? loc.action_yes_delete_all_title : loc.action_yes_delete_title,
                  type: ButtonType.danger,
                  result: true,
                ),
                MTDialogAction(title: loc.action_no_delete_title, result: false),
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
