// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../presenters/person.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'invitation_button.dart';
import 'member_view.dart';
import 'no_members.dart';

class TeamPane extends StatelessWidget {
  const TeamPane(this._controller);
  final TaskController _controller;

  Task get task => _controller.task;

  List<Member> get _sortedMembers => task.sortedMembers;

  Widget? get bottomBar => task.canInviteMembers ? InvitationButton(task) : null;

  Widget _memberBuilder(BuildContext context, int index) {
    final member = _sortedMembers[index];
    return MTListTile(
      leading: member.isActive ? member.icon(P4, borderColor: mainColor) : const LinkBreakIcon(color: f3Color, size: P8),
      middle: BaseText('$member', color: member.isActive ? null : f2Color),
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
