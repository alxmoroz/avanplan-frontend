// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';
import 'task_checklist_item.dart';

class TaskChecklist extends StatelessWidget {
  const TaskChecklist(this._taskController);
  final TaskController _taskController;

  SubtasksController get _controller => _taskController.subtasksController;

  Widget get _addButton => CreateTaskButton(
        _taskController,
        type: ButtonType.secondary,
        margin: const EdgeInsets.only(top: P3),
        uf: false,
        onTap: _controller.addTask,
      );

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == _controller.taskControllers.length) {
      return _addButton;
    } else {
      return TaskChecklistItem(_controller, index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        itemBuilder: _itemBuilder,
        itemCount: _controller.taskControllers.length + 1,
      ),
    );
  }
}
