// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';

class AccountView extends StatelessWidget {
  static String get routeName => '/account';
  static String get title => loc.account_title;

  User? get _user => accountController.user;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(
          context,
          title: title,
          trailing: MTButton.icon(const DeleteIcon(), onTap: accountController.delete, padding: const EdgeInsets.symmetric(horizontal: P2)),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _user != null
              ? ListView(
                  children: [
                    const SizedBox(height: P3),
                    _user!.icon(P10, borderColor: mainColor),
                    const SizedBox(height: P3),
                    H3('$_user', align: TextAlign.center),
                    BaseText(_user!.email, align: TextAlign.center),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
