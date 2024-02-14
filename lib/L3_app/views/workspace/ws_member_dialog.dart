// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/ws_member.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';

Future wsMemberDialog(WSMember wsMember) async => await showMTDialog<void>(_MemberDialog(wsMember));

class _MemberDialog extends StatelessWidget {
  const _MemberDialog(this._wsMember);
  final WSMember _wsMember;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, title: loc.member_title),
      body: ListView(
        shrinkWrap: true,
        children: [
          _wsMember.icon(P10),
          const SizedBox(height: P3),
          H2('$_wsMember', align: TextAlign.center),
          BaseText(_wsMember.email, align: TextAlign.center),
          if (_wsMember.roles.isNotEmpty) ...[
            MTListSection(titleText: loc.role_list_title),
            MTListTile(titleText: _wsMember.rolesStr, bottomDivider: false),
          ]
        ],
      ),
    );
  }
}
