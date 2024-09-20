// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/avatar.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/user.dart';
import '../../presenters/ws_member.dart';

Future wsUserDialog(Workspace ws, User user) async => await showMTDialog<void>(_WSUserDialog(ws, user));

class _WSUserDialog extends StatelessWidget {
  const _WSUserDialog(this._ws, this._user);
  final User _user;
  final Workspace _ws;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(
        showCloseButton: true,
        color: b2Color,
        pageTitle: loc.workspace_member_title,
        parentPageTitle: _ws.title,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          _user.icon(MAX_AVATAR_RADIUS),
          const SizedBox(height: P3),
          H2('$_user', align: TextAlign.center),
          BaseText(_user.email, align: TextAlign.center, maxLines: 1),
          if (_user.roles.isNotEmpty) ...[
            MTListGroupTitle(titleText: loc.role_title),
            MTListTile(
              titleText: _user.rolesTitles,
              subtitle: _user.rolesDescriptions.isNotEmpty ? SmallText(_user.rolesDescriptions, maxLines: 1) : null,
              bottomDivider: false,
            ),
          ]
        ],
      ),
    );
  }
}
