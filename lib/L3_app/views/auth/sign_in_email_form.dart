// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_dialog_button.dart';
import '../../components/mt_dialog.dart';
import '../../components/navbar.dart';
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
        topBar: navBar(
          context,
          leading: MTCloseDialogButton(),
          title: loc.auth_sign_in_email_dialog_title,
          bgColor: backgroundColor,
        ),
        body: Observer(
          builder: (_) => ListView(
            shrinkWrap: true,
            children: [
              controller.tf('email'),
              controller.tf('password'),
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
