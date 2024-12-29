// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../app/services.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension RepeatUC on TaskController {
  Future repeat() async => await editWrapper(() async {
        final changes = await taskUC.repeat(task);
        if (changes != null) {
          changes.updated.filled = true;
          tasksMainController.upsertTasks([changes.updated, ...changes.affected]);
        }
      });
}
