// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'user_icon.dart';

class AccountView extends StatelessWidget {
  static String get routeName => 'account_view';

  User? get _user => accountController.user;

  Future _logout(BuildContext context) async {
    Navigator.of(context).popUntil((r) => r.navigator?.canPop() == false);
    await authController.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, title: loc.account_title),
        body: SafeArea(
          top: false,
          child: _user != null
              ? ListView(
                  children: [
                    const SizedBox(height: P2),
                    UserIcon(_user!, radius: P2 * 3),
                    const SizedBox(height: P),
                    H3('$_user', align: TextAlign.center),
                    const SizedBox(height: P_2),
                    NormalText(_user!.email, align: TextAlign.center),
                    const SizedBox(height: P2),
                    MTButton.outlined(
                      margin: const EdgeInsets.symmetric(horizontal: P),
                      titleText: loc.auth_sign_out_btn_title,
                      titleColor: darkGreyColor,
                      trailing: const LogoutIcon(color: warningColor),
                      onTap: () async => await _logout(context),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
