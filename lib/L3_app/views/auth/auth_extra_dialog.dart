// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/icons.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import 'registration_form.dart';
import 'sign_in_email_dialog.dart';

Future authExtraDialog() async => await showMTDialog(const _AuthExtraDialog(), maxWidth: SCR_XS_WIDTH);

class _AuthExtraDialog extends StatelessWidget {
  const _AuthExtraDialog();

  void _mail(BuildContext context) {
    Navigator.of(context).pop();
    signInEmailDialog();
  }

  void _register(BuildContext context) {
    Navigator.of(context).pop();
    registrationDialog();
  }

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.auth_sign_in_extra_title),
      body: ListView(
        shrinkWrap: true,
        children: [
          MTButton(
            type: MTButtonType.main,
            constrained: true,
            leading: const MailIcon(color: mainColor, size: P4),
            middle: BaseText.medium(loc.auth_sign_in_email_title, color: mainColor),
            color: bwColor,
            margin: const EdgeInsets.only(top: P3),
            trailing: const SizedBox(width: P2),
            onTap: () => _mail(context),
          ),
          MTButton(
            type: MTButtonType.main,
            constrained: true,
            middle: BaseText.medium(loc.register_action_title, color: mainColor),
            color: bwColor,
            margin: const EdgeInsets.only(top: P3),
            onTap: () => _register(context),
          ),
        ],
      ),
      forceBottomPadding: true,
    );
  }
}
