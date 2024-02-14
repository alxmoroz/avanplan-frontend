// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/ws_member.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../presenters/person.dart';
import 'ws_member_dialog.dart';

class WSMemberTile extends StatelessWidget {
  const WSMemberTile(this._wsMember, {super.key, required this.bottomBorder});
  final WSMember _wsMember;
  final bool bottomBorder;

  static const _iconSize = P8;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: _wsMember.icon(_iconSize / 2, borderColor: mainColor),
      middle: BaseText('$_wsMember', maxLines: 1),
      subtitle: SmallText(_wsMember.rolesStr, maxLines: 1),
      trailing: const ChevronIcon(),
      bottomDivider: bottomBorder,
      dividerIndent: _iconSize + P5,
      onTap: () async => await wsMemberDialog(_wsMember),
    );
  }
}
