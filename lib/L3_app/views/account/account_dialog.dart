// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/user.dart';
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

class _AccountRoute extends MTRoute {
  _AccountRoute()
      : super(
          path: 'my_account',
          name: 'my_account',
          builder: (_, __) => const _AccountDialog(),
        );

  @override
  bool isDialog(BuildContext _) => true;

  @override
  String? title(GoRouterState _) => loc.my_account_title;
}

final accountRoute = _AccountRoute();

class _AccountDialog extends StatelessWidget {
  const _AccountDialog();

  User? get _me => accountController.me;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          title: loc.my_account_title,
          trailing: MTButton.icon(const DeleteIcon(), onTap: () => accountController.delete(context), padding: const EdgeInsets.all(P2)),
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
