// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../components/constants.dart';
import '../../../components/mt_select_dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/person_presenter.dart';
import '../../../usecases/task_available_actions.dart';
import 'task_controller.dart';

class AssigneeController {
  AssigneeController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task;

  Future _reset() async {
    final oldValue = task.assigneeId;
    task.assigneeId = null;
    if (!(await _taskController.saveField(TaskFCode.assignee))) {
      task.assigneeId = oldValue;
    }
  }

  Future assign() async {
    final selectedId = await showMTSelectDialog<Member>(
      task.activeMembers,
      task.assigneeId,
      loc.task_assignee_placeholder,
      valueBuilder: (_, member) => member.iconName(radius: P * 1.5),
      onReset: task.canAssign ? _reset : null,
    );
    if (selectedId != null) {
      final oldValue = task.assigneeId;
      task.assigneeId = selectedId;
      if (!(await _taskController.saveField(TaskFCode.assignee))) {
        task.assigneeId = oldValue;
      }
    }
  }
}
