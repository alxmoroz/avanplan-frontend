// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/member.dart';
import '../../../L1_domain/entities/task.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
import '../../components/text_widgets.dart';
import '../../presenters/person_presenter.dart';
import 'member_view.dart';

class MemberListTile extends StatelessWidget {
  const MemberListTile(this.member, this.task);
  final Member member;
  final Task task;

  Future _showMember(BuildContext context) async => Navigator.of(context).pushNamed(
        MemberView.routeName,
        arguments: MemberViewArgs(member, task),
      );

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: Padding(
        padding: const EdgeInsets.only(right: P_2),
        child: member.isActive ? member.icon(P2) : const UnlinkIcon(color: greyColor),
      ),
      middle: NormalText('$member', color: member.isActive ? null : greyColor),
      subtitle: member.isActive ? SmallText(member.rolesStr, color: greyColor) : null,
      trailing: const ChevronIcon(),
      bottomBorder: false,
      onTap: () => _showMember(context),
    );
  }
}
