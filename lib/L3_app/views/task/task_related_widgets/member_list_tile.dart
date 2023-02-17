// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/member.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/person_presenter.dart';

class MemberListTile extends StatelessWidget {
  const MemberListTile(this.member);
  final Member member;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: Padding(
        padding: const EdgeInsets.only(right: P_2),
        child: member.isActive ? member.icon(P2) : const UnlinkIcon(color: greyColor),
      ),
      middle: NormalText('$member', color: member.isActive ? null : greyColor),
      subtitle: member.isActive ? SmallText(member.rolesStr, color: greyColor) : null,
      // trailing: const ChevronIcon(),
      bottomBorder: false,
      // onTap: () => _showAccount(context),
    );
  }
}
