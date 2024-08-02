// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/avatar.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../../presenters/user.dart';

Future wsUserDialog(User user) async => await showMTDialog<void>(_WSUserDialog(user));

class _WSUserDialog extends StatelessWidget {
  const _WSUserDialog(this._user);
  final User _user;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.member_title),
      body: ListView(
        shrinkWrap: true,
        children: [
          _user.icon(MAX_AVATAR_RADIUS),
          const SizedBox(height: P3),
          H2('$_user', align: TextAlign.center),
          BaseText(_user.email, align: TextAlign.center, maxLines: 1),
          if (_user.roles.isNotEmpty) ...[
            MTListGroupTitle(titleText: loc.role_list_title),
            MTListTile(titleText: _user.rolesStr, bottomDivider: false),
          ]
        ],
      ),
    );
  }
}
