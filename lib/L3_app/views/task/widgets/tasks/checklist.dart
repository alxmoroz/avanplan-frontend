// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/task_type.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../app/services.dart';
import '../../controllers/subtasks_controller.dart';
import '../../controllers/task_controller.dart';
import 'checklist_item.dart';

class TaskChecklist extends StatelessWidget {
  const TaskChecklist(this._tc, {super.key});
  final TaskController _tc;
  Task get _t => _tc.task;
  SubtasksController get _stc => _tc.subtasksController;

  Widget get _addButton => MTField(
        const MTFieldData(-1),
        leading: const PlusIcon(circled: true, size: P6),
        value: BaseText(
          _t.hasSubtasks ? addTaskActionTitle(TType.CHECKLIST_ITEM) : '${loc.action_add_title} ${loc.checklist.toLowerCase()}',
          color: mainColor,
        ),
        onTap: _stc.add,
      );

  Widget _itemBuilder(_, int index) {
    return index == _stc.tasksControllers.length
        ? _addButton
        : TaskChecklistItem(
            _stc.tasksControllers.elementAt(index),
            key: ObjectKey(_stc.tasksControllers.elementAt(index)),
            bottomDivider: index < _stc.tasksControllers.length - 1 || _tc.canCreateChecklist,
            onSubmit: _stc.add,
            onDelete: () => _stc.delete(index),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: _itemBuilder,
        itemCount: _stc.tasksControllers.length + (_tc.canCreateChecklist ? 1 : 0),
      ),
    );
  }
}
