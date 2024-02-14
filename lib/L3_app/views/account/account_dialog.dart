// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/ws_member.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';

class AccountRouter extends MTRouter {
  @override
  String get path => '/settings/my_account';

  @override
  bool get isDialog => true;

  @override
  Widget get page => const _AccountDialog();

  @override
  String get title => loc.my_account_title;
}

class _AccountDialog extends StatelessWidget {
  const _AccountDialog();

  WSMember? get _me => accountController.me;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          title: loc.my_account_title,
          trailing: MTButton.icon(const DeleteIcon(), onTap: accountController.delete, padding: const EdgeInsets.all(P2)),
        ),
        body: _me != null
            ? ListView(
                shrinkWrap: true,
                children: [
                  _me!.icon(P10, borderColor: mainColor),
                  const SizedBox(height: P3),
                  H3('$_me', align: TextAlign.center),
                  BaseText(_me!.email, align: TextAlign.center),
                  const SizedBox(height: P3),
                  MTListTile(
                    middle: BaseText(loc.auth_sign_out_btn_title, color: dangerColor, align: TextAlign.center, maxLines: 1),
                    bottomDivider: false,
                    onTap: authController.signOut,
                  ),
                ],
              )
            : Container(),
      ),
    );
  }
}
