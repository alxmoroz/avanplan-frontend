// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_edit.dart';
import 'task_controller.dart';

class DuplicateController {
  DuplicateController(this._taskController);
  final TaskController _taskController;
  Task? get _task => _taskController.task;

  Future duplicate() async {
    if (_task != null) {
      loader.setSaving();
      router.pop();
      final newTask = await _task!.duplicate();
      if (newTask != null) {
        router.goLocalTask(newTask);
      }
      loader.stop();
    }
  }
}
