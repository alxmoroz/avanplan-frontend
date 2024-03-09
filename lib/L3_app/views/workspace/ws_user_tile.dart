// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../presenters/person.dart';
import 'ws_user_dialog.dart';

class WSUserTile extends StatelessWidget {
  const WSUserTile(this._user, {super.key, required this.bottomBorder});
  final User _user;
  final bool bottomBorder;

  static const _iconSize = P8;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      leading: _user.icon(_iconSize / 2, borderColor: mainColor),
      middle: BaseText('$_user', maxLines: 1),
      subtitle: SmallText(_user.rolesStr, maxLines: 1),
      trailing: const ChevronIcon(),
      bottomDivider: bottomBorder,
      dividerIndent: _iconSize + P5,
      onTap: () async => await wsUserDialog(_user),
    );
  }
}
