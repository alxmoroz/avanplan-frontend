// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/role.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/members.dart';

part 'member_roles_controller.g.dart';

class MemberRolesController extends _Base with _$MemberRolesController {
  MemberRolesController(TaskController tcIn, int memberIdIn) {
    _tc = tcIn;
    _memberId = memberIdIn;
    reload();
  }
}

abstract class _Base with Store {
  late final TaskController _tc;
  late final int _memberId;

  Task get task => _tc.task;
  WSMember? get member => task.memberForId(_memberId);

  @observable
  List<Role> roles = [];

  @action
  Future reload() async {
    roles = task.ws.roles.toList();
    for (var r in roles) {
      r.selected = member?.roles.contains(r.code) == true;
    }
  }

  @computed
  Iterable<Role> get selectedRoles => roles.where((r) => r.selected);

  @action
  void selectRole(Role role, bool? selected) {
    role.selected = selected == true;
    roles = [...roles];
  }

  Future assignRoles(BuildContext context) async {
    Navigator.of(context).pop();
    await _tc.assignMemberRoles(_memberId, selectedRoles.map((r) => r.id!));
  }
}
