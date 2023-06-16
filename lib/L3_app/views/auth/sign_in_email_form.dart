// Copyright (c) 2022. Alexandr Moroz

import 'package:avanplan/L3_app/components/mt_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dialog.dart';
import '../../extra/services.dart';
import 'sign_in_email_controller.dart';

Future showSignInEmailDialog() async => await showMTDialog<void>(SignInEmailForm());

class SignInEmailForm extends StatefulWidget {
  @override
  _SignInEmailFormState createState() => _SignInEmailFormState();
}

class _SignInEmailFormState extends State<SignInEmailForm> {
  late final SignInEmailController controller;

  @override
  void initState() {
    controller = SignInEmailController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MTDialog(
        topBar: MTTopBar(titleText: loc.auth_sign_in_email_dialog_title),
        body: Observer(
          builder: (_) => ListView(
            shrinkWrap: true,
            children: [
              controller.tf(SigninFCode.email, first: true),
              controller.tf(SigninFCode.password),
              const SizedBox(height: P2),
              MTButton.main(
                titleText: loc.auth_sign_in_email_action_title,
                onTap: controller.validated ? controller.signIn : null,
              ),
            ],
          ),
        ),
      );
}
