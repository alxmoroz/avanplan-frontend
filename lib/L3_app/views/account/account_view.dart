// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'account_header.dart';

class AccountView extends StatelessWidget {
  static String get routeName => 'account';

  Future logout() async => await loginController.logout();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: accountController.isLoading,
        navBar: navBar(context, title: loc.accountTitle),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(onePadding),
                child: const AccountHeader(expanded: true),
              ),
              MTRichButton(titleString: loc.auth_log_out_btn_title, suffix: logoutIcon(context), onTap: logout),
            ],
          ),
        ),
      ),
    );
  }
}
