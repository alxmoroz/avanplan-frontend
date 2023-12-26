// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_type.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';
import 'task_checklist_item.dart';

class TaskChecklist extends StatelessWidget {
  const TaskChecklist(this._taskController);
  final TaskController _taskController;

  SubtasksController get _controller => _taskController.subtasksController;

  Widget get _addButton => MTField(
        const MTFieldData(-1),
        leading: const PlusIcon(circled: true, size: P5),
        value: BaseText.f2(addSubtaskActionTitle(_taskController.task)),
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
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: _itemBuilder,
        itemCount: _controller.taskControllers.length + 1,
      ),
    );
  }
}
