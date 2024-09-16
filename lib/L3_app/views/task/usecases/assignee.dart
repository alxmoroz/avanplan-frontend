// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import '../../../../L1_domain/entities/ws_member.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../components/constants.dart';
import '../../../components/select_dialog.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_actions.dart';
import '../../../presenters/ws_member.dart';
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
    final assignee = await showMTSelectDialog<WSMember>(
      task.activeMembers,
      task.assigneeId,
      loc.task_assignee_placeholder,
      parentPageTitle: task.title,
      leadingBuilder: (_, member) => member.icon(P3),
      valueBuilder: (_, member) => BaseText('$member', maxLines: 1),
      dividerIndent: P6 + P5,
      onReset: task.canAssign ? _reset : null,
    );

    final oldAssigneeId = task.assigneeId;
    if (assignee != null && assignee.id != oldAssigneeId) {
      task.assigneeId = assignee.id;
      tasksMainController.refreshUI();
      await _assign(oldAssigneeId);
    }
  }
}
