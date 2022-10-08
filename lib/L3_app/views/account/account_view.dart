// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_list_tile.dart';
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
    await authController.logout();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: accountController.isLoading,
        navBar: navBar(context, title: loc.accountTitle),
        body: SafeArea(
          top: false,
          child: _user != null
              ? ListView(
                  children: [
                    SizedBox(height: onePadding * 2),
                    UserIcon(_user!, radius: onePadding * 5),
                    SizedBox(height: onePadding),
                    H3('$_user', align: TextAlign.center),
                    SizedBox(height: onePadding / 2),
                    NormalText(_user!.email, align: TextAlign.center),
                    SizedBox(height: onePadding * 2),
                    MTListTile(
                      middle: NormalText(loc.auth_log_out_btn_title),
                      onTap: () async => await _logout(context),
                      trailing: logoutIcon(context),
                      topBorder: true,
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
