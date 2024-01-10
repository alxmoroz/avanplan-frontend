// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L3_app/components/colors_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
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
  Widget get page => const AccountDialog();

  @override
  String get title => loc.my_account_title;
}

class AccountDialog extends StatelessWidget {
  const AccountDialog({super.key});

  User? get _user => accountController.user;

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
        body: _user != null
            ? ListView(
                shrinkWrap: true,
                children: [
                  _user!.icon(P10, borderColor: mainColor),
                  const SizedBox(height: P3),
                  H3('$_user', align: TextAlign.center),
                  BaseText(_user!.email, align: TextAlign.center),
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
