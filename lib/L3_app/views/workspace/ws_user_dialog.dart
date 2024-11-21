// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/user.dart';
import '../../../L1_domain/entities/workspace.dart';
import '../../components/avatar.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/linkify/linkify.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/user.dart';
import '../../presenters/ws_member.dart';

Future wsUserDialog(Workspace ws, User user) async => await showMTDialog(_WSUserDialog(ws, user));

class _WSUserDialog extends StatelessWidget {
  const _WSUserDialog(this._ws, this._user);
  final User _user;
  final Workspace _ws;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.workspace_member_title, parentPageTitle: _ws.title),
      body: ListView(
        shrinkWrap: true,
        children: [
          /// Аватарка
          const SizedBox(height: P3),
          _user.icon(MAX_AVATAR_RADIUS),

          /// Имя, фамилия
          const SizedBox(height: P3),
          MTLinkify('$_user', style: const H2('').style(context), textAlign: TextAlign.center),
          const SizedBox(height: P_2),
          SmallText(_user.email, align: TextAlign.center, maxLines: 1),

          /// Права в РП
          const SizedBox(height: P3),
          MTListTile(
            leading: const PrivacyIcon(color: f2Color),
            middle: BaseText(loc.role_title, maxLines: 1),
            subtitle: SmallText(_user.rolesTitles, maxLines: 1),
            bottomDivider: false,
          ),
        ],
      ),
    );
  }
}
