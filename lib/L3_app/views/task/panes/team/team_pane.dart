// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_adaptive.dart';
import '../../../../components/mt_list_tile.dart';
import '../../../../components/mt_shadowed.dart';
import '../../../../components/text_widgets.dart';
import '../../../../presenters/person_presenter.dart';
import '../../../../usecases/task_ext_actions.dart';
import '../../task_view_controller.dart';
import 'member_add_menu.dart';
import 'member_view.dart';
import 'no_members.dart';

class TeamPane extends StatelessWidget {
  const TeamPane(this.controller);
  final TaskViewController controller;

  Task get task => controller.task;

  List<Member> get _sortedMembers => task.sortedMembers;

  Widget? get bottomBar => task.canEditMembers && task.ws.roles.isNotEmpty ? MemberAddMenu(task) : null;

  Widget _memberBuilder(BuildContext context, int index) {
    final member = _sortedMembers[index];
    return MTListTile(
      topIndent: index == 0 ? P_2 : 0,
      leading: Padding(
        padding: const EdgeInsets.only(right: P_2),
        child: member.isActive ? member.icon(P2) : const LinkBreakIcon(color: greyTextColor),
      ),
      middle: NormalText('$member', color: member.isActive ? null : greyTextColor),
      subtitle: member.isActive ? SmallText(member.rolesStr) : null,
      trailing: const ChevronIcon(),
      bottomDivider: index < _sortedMembers.length - 1,
      onTap: () async => await Navigator.of(context).pushNamed(
        MemberView.routeName,
        arguments: MemberViewArgs(member, task),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTShadowed(
        child: MTAdaptive(
          child: _sortedMembers.isNotEmpty
              ? ListView.builder(
                  itemBuilder: _memberBuilder,
                  itemCount: _sortedMembers.length,
                )
              : Center(child: NoMembers()),
        ),
      ),
    );
  }
}
