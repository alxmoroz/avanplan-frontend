// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/components/colors.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/member.dart';
import '../../../components/constants.dart';
import '../../../components/mt_list_tile.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/person_icon.dart';
import '../../../presenters/person_presenter.dart';

class MemberListTile extends StatelessWidget {
  const MemberListTile(this.member);
  final Member member;

  String get _title => '$member';
  String get _subtitle => member.rolesStr;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: Padding(
        padding: const EdgeInsets.only(right: P_2),
        child: PersonIcon(member, radius: P2),
      ),
      middle: NormalText(_title),
      subtitle: SmallText(_subtitle, color: greyColor),
      // trailing: const ChevronIcon(),
      bottomBorder: false,
      // onTap: () => _showAccount(context),
    );
  }
}
