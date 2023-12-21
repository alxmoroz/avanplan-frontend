// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/member.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/person.dart';
import '../../controllers/task_controller.dart';
import 'member_dialog.dart';
import 'no_members.dart';

class Team extends StatelessWidget {
  const Team(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;
  List<Member> get _sortedMembers => _task.sortedMembers;

  // Widget? get bottomBar => _task.canInviteMembers ? MTAppBar(isBottom: true, bgColor: b2Color, middle: InvitationButton(_task)) : null;

  Widget _memberBuilder(BuildContext context, int index) {
    final member = _sortedMembers[index];
    return MTListTile(
      leading: member.isActive ? member.icon(P4, borderColor: mainColor) : const PersonIcon(size: P8, color: f3Color),
      middle: BaseText('$member', color: member.isActive ? null : f2Color, maxLines: 1),
      subtitle: member.isActive ? SmallText(member.rolesStr, maxLines: 1) : null,
      trailing: const ChevronIcon(),
      bottomDivider: index < _sortedMembers.length - 1,
      onTap: () async => await showMemberDialog(_controller, member.id!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _sortedMembers.isNotEmpty
          ? ListView.builder(
              shrinkWrap: true,
              itemBuilder: _memberBuilder,
              itemCount: _sortedMembers.length,
            )
          : Center(child: NoMembers()),
    );
  }
}
