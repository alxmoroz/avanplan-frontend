// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/adaptive.dart';
import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/shadowed.dart';
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
          child: MTShadowed(
            child: MTAdaptive(
              child: _user != null
                  ? ListView(
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
          ),
        ),
      ),
    );
  }
}
