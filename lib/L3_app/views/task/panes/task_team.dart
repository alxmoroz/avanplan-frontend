// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L1_domain/entities_extensions/task_level.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/member.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../components/constants.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';
import 'team/member_add_menu.dart';
import 'team/member_list_tile.dart';

class MemberListView extends StatelessWidget {
  const MemberListView(this.controller);
  final TaskViewController controller;

  Task get task => controller.task;

  List<Member> get _sortedMembers => task.sortedMembers;

  Widget? get bottomBar => !task.isRoot && task.canEditMembers && task.ws.roles.isNotEmpty ? MemberAddMenu(task) : null;

  Widget _itemBuilder(BuildContext context, int index) => MemberListTile(_sortedMembers[index], task);

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return Observer(
      builder: (_) => ListView.builder(
        shrinkWrap: true,
        padding: padding.add(EdgeInsets.only(bottom: padding.bottom > 0 ? 0 : P, top: P_2)),
        itemBuilder: _itemBuilder,
        itemCount: _sortedMembers.length,
      ),
    );
  }
}
