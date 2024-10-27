// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../extra/services.dart';
import '../../../navigation/router.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension DuplicateUC on TaskController {
  Future duplicate() async => await editWrapper(() async {
        if (await taskDescriptor.ws.checkBalance(loc.task_duplicate_action_title)) {
          final changes = await taskUC.duplicate(task);
          if (changes != null) {
            changes.updated.filled = true;
            tasksMainController.upsertTasks([changes.updated, ...changes.affected]);
            router.goTaskFromTask(changes.updated, task);
          }
        }
      });
}
