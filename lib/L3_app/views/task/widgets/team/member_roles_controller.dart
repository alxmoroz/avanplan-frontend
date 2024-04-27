// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/role.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_tree.dart';
import '../../../../usecases/ws_tariff.dart';

part 'member_roles_controller.g.dart';

class MemberRolesController extends _MemberRolesControllerBase with _$MemberRolesController {
  MemberRolesController(Task taskIn, int memberIdIn) {
    task = taskIn;
    memberId = memberIdIn;
    final member = task.memberForId(memberId);
    roles = task.ws.roles.toList();
    for (var r in roles) {
      r.selected = member!.roles.contains(r.code);
    }
  }
}

abstract class _MemberRolesControllerBase with Store {
  late final Task task;
  late final int memberId;

  @observable
  List<Role> roles = [];

  @computed
  Iterable<Role> get selectedRoles => roles.where((r) => r.selected);

  @action
  void selectRole(Role role, bool? selected) {
    role.selected = selected == true;
    roles = [...roles];
  }

  Future assignRoles(BuildContext context) async {
    context.pop();

    if (await task.ws.checkBalance(loc.member_edit_action_title)) {
      // TODO: вынести в юзкейс. См. как сделано с комментами
      task.loading = true;
      tasksMainController.refreshTasksUI();

      final rolesIds = selectedRoles.map((r) => r.id!);
      task.members = await taskMemberRoleUC.assignRoles(task, memberId, rolesIds);
      final deleted = task.memberForId(memberId) == null;
      if (deleted) {
        if (task.assigneeId == memberId) {
          task.assigneeId = null;
        }
        if (task.authorId == memberId) {
          task.authorId = null;
        }
      }

      task.loading = false;
      tasksMainController.refreshTasksUI();
    }
  }
}
