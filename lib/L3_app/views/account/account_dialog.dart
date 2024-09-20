// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/user.dart';
import '../../components/avatar.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/route.dart';
import '../../extra/services.dart';
import '../../presenters/user.dart';
import '../../views/_base/loader_screen.dart';
import 'edit_avatar_dialog.dart';
import 'usecases/contacts.dart';
import 'usecases/edit.dart';

class AccountRoute extends MTRoute {
  static const staticBaseName = 'my_account';

  AccountRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, __) => const _AccountDialog(),
        );

  @override
  bool isDialog(BuildContext context) => true;

  @override
  String? title(GoRouterState state) => loc.my_account_title;
}

class _AccountDialog extends StatefulWidget {
  const _AccountDialog();

  @override
  State<_AccountDialog> createState() => _State();
}

class _State extends State<_AccountDialog> {
  User? get _me => accountController.me;

  @override
  void initState() {
    accountController.loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => accountController.loading || _me == null
          ? LoaderScreen(accountController, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                pageTitle: loc.my_account_title,
                trailing: MTButton.icon(const DeleteIcon(), onTap: () => accountController.delete(context), padding: const EdgeInsets.all(P2)),
              ),
              body: ListView(
                shrinkWrap: true,
                children: [
                  MTButton(middle: _me!.icon(MAX_AVATAR_RADIUS, borderColor: mainColor), onTap: editAvatarDialog),
                  MTButton(
                    titleText: loc.avatar_edit_action_title,
                    margin: const EdgeInsets.all(P3),
                    onTap: editAvatarDialog,
                  ),
                  const SizedBox(height: P),
                  H3('$_me', align: TextAlign.center),
                  BaseText(_me!.email, align: TextAlign.center, maxLines: 1),
                  const SizedBox(height: P3),
                  MTListTile(
                    middle: BaseText(loc.auth_sign_out_btn_title, color: dangerColor, align: TextAlign.center, maxLines: 1),
                    bottomDivider: false,
                    onTap: authController.signOut,
                  ),
                ],
              ),
            ),
    );
  }
}
