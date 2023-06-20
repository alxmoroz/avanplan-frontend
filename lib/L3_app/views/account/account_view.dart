// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';

class AccountView extends StatelessWidget {
  static String get routeName => '/account';

  User? get _user => accountController.user;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          title: loc.account_title,
          trailing: MTButton.icon(const DeleteIcon(), () => accountController.delete(context), margin: const EdgeInsets.only(right: P)),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _user != null
              ? ListView(
                  children: [
                    const SizedBox(height: P2),
                    _user!.icon(P2 * 3),
                    const SizedBox(height: P),
                    H2('$_user', align: TextAlign.center),
                    const SizedBox(height: P_2),
                    NormalText(_user!.email, align: TextAlign.center),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
