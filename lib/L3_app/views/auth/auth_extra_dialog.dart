// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import 'registration_form.dart';
import 'sign_in_email_dialog.dart';

Future authExtraDialog() async => await showMTDialog<void>(const _AuthExtraDialog(), maxWidth: SCR_XS_WIDTH);

class _AuthExtraDialog extends StatelessWidget {
  const _AuthExtraDialog();

  void _mail() {
    router.pop();
    signInEmailDialog();
  }

  void _register() {
    router.pop();
    registrationDialog();
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(title: loc.auth_sign_in_extra_title, color: b2Color, showCloseButton: true),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTButton.main(
            leading: const MailIcon(color: f1Color, size: P4),
            middle: BaseText.medium(loc.auth_sign_in_email_title, color: f1Color),
            color: b3Color,
            margin: const EdgeInsets.only(top: P3),
            trailing: const SizedBox(width: P2),
            onTap: _mail,
          ),
          MTButton.main(
            middle: BaseText.medium(loc.register_action_title, color: f1Color),
            color: b3Color,
            margin: const EdgeInsets.only(top: P3),
            onTap: _register,
          ),
          if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P6),
        ],
      ),
    );
  }
}
