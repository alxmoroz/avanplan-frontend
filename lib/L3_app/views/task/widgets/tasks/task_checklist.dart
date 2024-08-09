// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';
import 'task_checklist_item.dart';

class TaskChecklist extends StatelessWidget {
  const TaskChecklist(this._taskController, {super.key});
  final TaskController _taskController;
  Task get _task => _taskController.task;
  SubtasksController get _controller => _taskController.subtasksController;

  Widget get _addButton => MTField(
        const MTFieldData(-1),
        leading: const PlusIcon(circled: true, size: P6),
        value: BaseText.f2(_task.hasSubtasks ? addSubtaskActionTitle(_task) : '${loc.action_add_title} ${loc.checklist.toLowerCase()}'),
        onTap: _controller.add,
      );

  Widget _itemBuilder(BuildContext _, int index) {
    return index == _controller.tasksControllers.length
        ? _addButton
        : TaskChecklistItem(
            _controller.tasksControllers.elementAt(index),
            key: ObjectKey(_controller.tasksControllers.elementAt(index)),
            bottomDivider: index < _controller.tasksControllers.length - 1 || _task.canCreateChecklist,
            onSubmit: _controller.add,
            onDelete: () => _controller.delete(index),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: _itemBuilder,
        itemCount: _controller.tasksControllers.length + (_task.canCreateChecklist ? 1 : 0),
      ),
    );
  }
}
