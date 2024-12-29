// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../app/services.dart';
import 'sign_in_email_controller.dart';

Future signInEmailDialog() async => await showMTDialog(const _SignInEmailDialog());

class _SignInEmailDialog extends StatefulWidget {
  const _SignInEmailDialog();

  @override
  State<StatefulWidget> createState() => _SignInEmailDialogState();
}

class _SignInEmailDialogState extends State<_SignInEmailDialog> {
  late final SignInEmailController sec;

  @override
  void initState() {
    sec = SignInEmailController();
    super.initState();
  }

  @override
  void dispose() {
    sec.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MTDialog(
        topBar: MTTopBar(pageTitle: loc.auth_sign_in_email_dialog_title),
        body: Observer(
          builder: (_) => ListView(
            shrinkWrap: true,
            children: [
              sec.tf(SigninFCode.email, first: true),
              sec.tf(SigninFCode.password),
              MTButton.main(
                titleText: loc.auth_sign_in_email_action_title,
                margin: const EdgeInsets.only(top: P3),
                onTap: sec.validated ? () => sec.signIn(context) : null,
              ),
            ],
          ),
        ),
        forceBottomPadding: true,
        hasKBInput: true,
      );
}
