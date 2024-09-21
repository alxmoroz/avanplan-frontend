// Copyright (c) 2024. Alexandr Moroz

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_tree.dart';
import '../../../usecases/ws_actions.dart';
import '../controllers/task_controller.dart';
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

extension TaskMemberUC on TaskController {
  Future assignMemberRoles(int memberId, Iterable<int> rolesIds) async {
    if (await task.ws.checkBalance(loc.member_edit_action_title)) {
      await editWrapper(() async {
        setLoaderScreenSaving();
        task.members = await taskMemberRoleUC.assignMemberRoles(task, memberId, rolesIds);
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
