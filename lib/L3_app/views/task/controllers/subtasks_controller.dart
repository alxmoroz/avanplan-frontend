// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../components/constants.dart';
import '../../../components/mt_button.dart';
import '../../../extra/services.dart';
import 'task_controller.dart';

part 'subtasks_controller.g.dart';

class SubtasksController extends _SubtasksControllerBase with _$SubtasksController {
  SubtasksController(TaskController _taskController) {
    taskController = _taskController;
  }
}

abstract class _SubtasksControllerBase with Store {
  late final TaskController taskController;

  Task get task => taskController.task;

  @observable
  bool _loading = false;

  @action
  Future _loadClosed() async {
    _loading = true;
    final tasks = await myUC.getTasks(task.ws, parent: task, closed: true);
    if (tasks.isNotEmpty) {
      task.tasks.addAll(tasks);
      mainController.addTasks(tasks);
    }
    _loading = false;
  }

  Widget? get loadClosedButton => (task.closedSubtasksCount ?? 0) > 0 && task.closedSubtasks.isEmpty
      ? MTButton.secondary(
          titleText: loc.show_closed_action_title,
          margin: const EdgeInsets.symmetric(vertical: P),
          loading: _loading,
          onTap: _loadClosed,
        )
      : null;
}
