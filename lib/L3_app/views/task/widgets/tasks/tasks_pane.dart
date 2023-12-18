// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../empty_state/no_tasks.dart';
import 'tasks_board.dart';
import 'tasks_list_view.dart';

class TasksPane extends StatelessWidget {
  const TasksPane(this.controller);
  final TaskController controller;

  Task get _task => controller.task!;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => !_task.hasSubtasks
          ? NoTasks(controller)
          : _task.canShowBoard && controller.showBoard
              ? TasksBoard(
                  controller.statusController,
                  extra: controller.subtasksController.loadClosedButton(board: true),
                )
              : TasksListView(
                  _task.subtaskGroups,
                  scrollable: false,
                  extra: controller.subtasksController.loadClosedButton(),
                ),
    );
  }
}
