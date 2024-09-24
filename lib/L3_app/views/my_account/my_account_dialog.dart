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
import '../../components/linkify.dart';
import '../../components/list_tile.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/route.dart';
import '../../extra/services.dart';
import '../../presenters/contact.dart';
import '../../presenters/user.dart';
import '../../views/_base/loader_screen.dart';
import 'my_avatar_edit_dialog.dart';
import 'my_contact_edit_dialog.dart';
import 'usecases/contacts.dart';
import 'usecases/edit.dart';

class MyAccountRoute extends MTRoute {
  static const staticBaseName = 'my_account';

  MyAccountRoute({super.parent})
      : super(
          baseName: staticBaseName,
          path: staticBaseName,
          builder: (_, __) => const _MyAccountDialog(),
        );

  @override
  bool isDialog(BuildContext context) => true;

  @override
  String? title(GoRouterState state) => loc.my_account_title;
}

class _MyAccountDialog extends StatefulWidget {
  const _MyAccountDialog();

  @override
  State<_MyAccountDialog> createState() => _State();
}

class _State extends State<_MyAccountDialog> {
  User? get _me => myAccountController.me;

  @override
  void initState() {
    myAccountController.loadContacts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => myAccountController.loading || _me == null
          ? LoaderScreen(myAccountController, isDialog: true)
          : MTDialog(
              topBar: MTAppBar(
                showCloseButton: true,
                color: b2Color,
                pageTitle: loc.my_account_title,
                trailing: MTButton.icon(const DeleteIcon(), onTap: () => myAccountController.delete(context), padding: const EdgeInsets.all(P2)),
              ),
              body: ListView(
                shrinkWrap: true,
                children: [
                  /// Аватарка
                  const SizedBox(height: P3),
                  MTButton(middle: _me!.icon(MAX_AVATAR_RADIUS, borderColor: mainColor), onTap: showMyAvatarEditDialog),
                  MTButton(
                    titleText: loc.avatar_edit_action_title,
                    margin: const EdgeInsets.all(P3),
                    onTap: showMyAvatarEditDialog,
                  ),

                  /// Имя, фамилия
                  const SizedBox(height: P),
                  MTLinkify('$_me', style: const H2('').style(context), textAlign: TextAlign.center),
                  const SizedBox(height: P_2),
                  SmallText(_me!.email, align: TextAlign.center, maxLines: 1),

                  /// Способы связи
                  const SizedBox(height: P3),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: myAccountController.contacts.length,
                    itemBuilder: (_, index) {
                      final c = myAccountController.contacts[index];
                      final value = BaseText(c.value, maxLines: 1);
                      return MTListTile(
                        leading: c.icon,
                        middle: c.hasDescription ? SmallText(c.description, maxLines: 1) : value,
                        subtitle: c.hasDescription ? value : null,
                        trailing: const EditIcon(),
                        dividerIndent: P11,
                        loading: c.loading,
                        onTap: () => showMyContactEditDialog(contact: c),
                      );
                    },
                  ),

                  MTListTile(
                    leading: const PlusIcon(circled: true, size: P6),
                    middle: BaseText('${loc.action_add_title} ${loc.person_contact_title.toLowerCase()}', maxLines: 1, color: mainColor),
                    bottomDivider: false,
                    onTap: showMyContactEditDialog,
                  ),

                  /// Выход из системы
                  const SizedBox(height: P6),
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
