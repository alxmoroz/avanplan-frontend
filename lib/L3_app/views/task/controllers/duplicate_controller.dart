// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../main.dart';
import '../../../extra/router.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_edit.dart';
import '../task_view.dart';
import 'task_controller.dart';

class DuplicateController {
  Future duplicate(Task task) async {
    loader.setSaving();
    Navigator.of(rootKey.currentContext!).pop();
    final newTask = await task.duplicate();
    if (newTask != null) {
      MTRouter.navigate(TaskRouter, rootKey.currentContext!, args: TaskController(newTask));
    }
    loader.stop();
  }
}
