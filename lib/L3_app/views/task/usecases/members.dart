// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/tariff_option.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../../app/services.dart';
import '../controllers/task_controller.dart';
import '../widgets/team/invitation_dialog.dart';
import '../widgets/team/project_team_dialog.dart';
import 'edit.dart';

extension TaskMemberLinkUC on Task {
  void removeAssignmentFromTaskTree(int memberId) {
    for (Task t in subtasks) {
      t.removeAssignmentFromTaskTree(memberId);
    }
    if (assigneeId == memberId) {
      assigneeId = null;
    }
  }
}

extension TaskMembersUC on TaskController {
  Future showTeam() async {
    final t = task;
    // проверка наличия функции
    if (await t.ws.checkFeature(TOCode.TEAM)) {
      if (t.members.isEmpty) {
        await invite(t);
      } else {
        await showProjectTeamDialog(this);
      }
    }
  }

  Future assignMemberRoles(int memberId, Iterable<int> rolesIds) async {
    if (await task.ws.checkBalance(loc.member_edit_action_title)) {
      await editWrapper(() async {
        setLoaderScreenSaving();
        task.members = await projectMembersUC.assignMemberRoles(task.wsId, task.id!, memberId, rolesIds);
        // Отключение от проекта
        if (rolesIds.isEmpty) {
          // для всех задач проекта и самого проекта тоже, где пользователь быз назначен, убрать назначение с него
          // на бэке должно обработаться в методе выше
          task.removeAssignmentFromTaskTree(memberId);
        }
      });
    }
  }
}
