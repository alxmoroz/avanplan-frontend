// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/usecases/task_ext_members.dart';
import '../../../components/constants.dart';
import '../../../extra/services.dart';
import '../../../usecases/task_ext_actions.dart';
import '../members/member_add_menu.dart';
import '../members/member_list_tile.dart';
import '../members/tmr_controller.dart';

class TaskTeam extends StatelessWidget {
  const TaskTeam(this.controller);
  final TMRController controller;

  List<Member> get _sortedMembers => controller.task.sortedMembers;

  Widget? get bottomBar => controller.task.canEditMembers && controller.allowedRoles.isNotEmpty
      ? MemberAddMenu(
          controller,
          title: loc.member_new_title,
          margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
        )
      : null;

  Widget _itemBuilder(BuildContext context, int index) => MemberListTile(_sortedMembers[index], controller.task);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ListView.builder(
      shrinkWrap: true,
      padding: padding.add(EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : P, top: P_2)),
      itemBuilder: _itemBuilder,
      itemCount: _sortedMembers.length,
    );
  }
}
