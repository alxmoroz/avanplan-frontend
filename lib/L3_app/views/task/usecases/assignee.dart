// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/select_dialog.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/person.dart';
import '../../../usecases/task_actions.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension AssigneeUC on TaskController {
  Future _reset() async {
    final oldAssigneeId = task.assigneeId;
    task.assigneeId = null;
    await _assign(oldAssigneeId);
  }

  Future _assign(int? oldAssigneeId) async {
    if (!(await saveField(TaskFCode.assignee))) {
      task.assigneeId = oldAssigneeId;
    }
  }

  Future startAssign() async {
    final assignee = await showMTSelectDialog<TaskMember>(
      task.activeMembers,
      task.assigneeId,
      loc.task_assignee_placeholder,
      leadingBuilder: (_, member) => member.icon(P3, borderColor: mainColor),
      valueBuilder: (_, member) => BaseText('$member', maxLines: 1),
      dividerIndent: P6 + P5,
      onReset: task.canAssign ? _reset : null,
    );

    final oldAssigneeId = task.assigneeId;
    if (assignee != null && assignee.id != oldAssigneeId) {
      task.assigneeId = assignee.id;
      tasksMainController.refreshTasksUI();
      await _assign(oldAssigneeId);
    }
  }
}
