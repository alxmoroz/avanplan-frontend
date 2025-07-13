// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../presenters/user.dart';
import '../../presenters/ws_member.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import 'ws_user_dialog.dart';

class WSUserTile extends StatelessWidget {
  const WSUserTile(this._ws, this._user, {super.key, required this.bottomDivider});
  final User _user;
  final Workspace _ws;
  final bool bottomDivider;

  static const _iconSize = P8;

  @override
  Widget build(BuildContext context) {
    return MTListTile(
      color: b3Color,
      leading: _user.icon(_iconSize / 2),
      middle: BaseText('$_user', maxLines: 1),
      subtitle: SmallText(_user.rolesTitles, maxLines: 1),
      trailing: kIsWeb ? null : const ChevronIcon(),
      bottomDivider: bottomDivider,
      dividerIndent: _iconSize + P5,
      onTap: () => wsUserDialog(_ws, _user),
    );
  }
}
