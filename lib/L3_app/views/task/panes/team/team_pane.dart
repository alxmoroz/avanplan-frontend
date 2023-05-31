// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/mt_shadowed.dart';
import '../../../../usecases/task_ext_actions.dart';
import '../../task_view_controller.dart';
import 'member_add_menu.dart';
import 'member_list_tile.dart';

class TeamPane extends StatelessWidget {
  const TeamPane(this.controller);
  final TaskViewController controller;

  Task get task => controller.task;

  List<Member> get _sortedMembers => task.sortedMembers;

  Widget? get bottomBar => !task.isRoot && task.canEditMembers && task.ws.roles.isNotEmpty ? MemberAddMenu(task) : null;

  Widget _itemBuilder(BuildContext context, int index) => MemberListTile(_sortedMembers[index], task);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        child: ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: _sortedMembers.length,
        ),
      ),
    );
  }
}
