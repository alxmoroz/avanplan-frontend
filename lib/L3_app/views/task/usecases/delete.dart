// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities_extensions/task_relation.dart';
import '../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../components/alert_dialog.dart';
import '../../../components/button.dart';
import '../../../components/images.dart';
import '../../../extra/services.dart';
import '../../../navigation/router.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/task_type.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension DeleteUC on TaskController {
  Future get _confirmDelete async {
    final hasSubtasks = task.hasSubtasks;
    return await showMTAlertDialog(
          imageName: ImageName.delete.name,
          title: task.hasSubtasks ? loc.task_delete_dialog_group_title : task.deleteDialogTitle,
          description: loc.delete_dialog_description,
          actions: [
            MTDialogAction(
              title: hasSubtasks ? loc.action_yes_delete_all_title : loc.action_yes_delete_title,
              type: MTButtonType.danger,
              result: true,
            ),
            MTDialogAction(title: loc.action_no_dont_delete_title, result: false),
          ],
        ) ==
        true;
  }

  Future<bool> delete({bool pop = false}) async {
    bool res = false;
    final t = task;
    if (t.isCheckItem || await _confirmDelete) {
      if (pop) router.pop();

      await editWrapper(() async {
        final changes = await taskUC.delete(taskDescriptor);
        if (changes != null) {
          tasksMainController.upsertTasks(changes.affected);
          tasksMainController.removeTask(t);

          for (var r in t.relations) {
            final relatedTask = tasksMainController.task(t.wsId, r.relatedTaskId(t.id!));
            if (relatedTask?.filled == true) {
              relatedTask!.relations.remove(r);
            }
          }
          res = true;
        }
      });
    }
    return res;
  }
}
