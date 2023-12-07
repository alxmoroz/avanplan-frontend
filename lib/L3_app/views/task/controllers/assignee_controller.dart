// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../components/constants.dart';
import '../../../components/select_dialog.dart';
import '../../../extra/services.dart';
import '../../../presenters/member.dart';
import '../../../usecases/task_actions.dart';
import 'task_controller.dart';

class AssigneeController {
  AssigneeController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task!;

  Future _reset() async {
    _assigneeEditTimer?.cancel();
    final oldAssigneeId = task.assigneeId;
    task.assigneeId = null;
    await _assign(oldAssigneeId);
  }

  Future _assign(int? oldAssigneeId) async {
    if (!(await _taskController.saveField(TaskFCode.assignee))) {
      task.assigneeId = oldAssigneeId;
    }
  }

  Timer? _assigneeEditTimer;

  Future startAssign() async {
    final assignee = await showMTSelectDialog<Member>(
      task.activeMembers,
      task.assigneeId,
      loc.task_assignee_placeholder,
      valueBuilder: (_, member) => member.iconName(radius: P3),
      onReset: task.canAssign ? _reset : null,
    );

    final oldAssigneeId = task.assigneeId;
    if (assignee != null && assignee.id != oldAssigneeId) {
      _assigneeEditTimer?.cancel();
      task.assigneeId = assignee.id;
      tasksMainController.refreshTasks();
      _assigneeEditTimer = Timer(const Duration(seconds: 0), () async => await _assign(oldAssigneeId));
    }
  }
}
