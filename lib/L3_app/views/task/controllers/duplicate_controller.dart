// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_edit.dart';
import 'task_controller.dart';

class DuplicateController {
  DuplicateController(this._taskController);
  final TaskController _taskController;
  Task? get _task => _taskController.task;

  Future duplicate(BuildContext context) async {
    if (_task != null) {
      loader.setSaving();
      context.pop();
      final newTask = await _task!.duplicate();
      if (newTask != null && context.mounted) {
        context.goLocalTask(newTask);
      }
      loader.stop();
    }
  }
}
