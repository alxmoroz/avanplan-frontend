// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/role.dart';
import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';
import '../../usecases/task_ext_actions.dart';

part 'member_edit_controller.g.dart';

class MemberEditController extends _MemberEditControllerBase with _$MemberEditController {
  MemberEditController(Task _task, Member _member) {
    task = _task;
    member = _member;
    roles = task.allowedRoles.toList();
    roles.forEach((r) => r.selected = member.roles.contains(r.code));
  }
}

abstract class _MemberEditControllerBase with Store {
  late final Task task;
  late final Member member;

  @observable
  List<Role> roles = [];

  @action
  void selectRole(Role role, bool? selected) {
    role.selected = selected == true;
    roles = [...roles];
  }

  Future assignRoles(BuildContext context) async {
    final rolesIds = roles.where((r) => r.selected).map((r) => r.id!);
    await taskMemberRoleUC.assignRoles(task.wsId, task.id!, member.id!, rolesIds);
    Navigator.of(context).pop();
  }
}
