// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'sign_in_email_controller.dart';

Future showSignInEmailDialog() async {
  return await showModalBottomSheet<void>(
    context: rootKey.currentContext!,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(SignInEmailForm()),
  );
}

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
  Widget build(BuildContext context) => MTPage(
        navBar: navBar(
          context,
          title: loc.auth_sign_in_email_dialog_title,
          bgColor: backgroundColor,
        ),
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: SCR_S_WIDTH),
              child: LayoutBuilder(
                builder: (_, size) => Observer(
                  builder: (_) => ListView(
                    shrinkWrap: true,
                    children: [
                      appIcon(size: size.maxHeight / 4),
                      controller.tf('email'),
                      controller.tf('password'),
                      MTButton.outlined(
                        margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                        titleText: loc.auth_sign_in_email_action_title,
                        onTap: controller.validated ? controller.signIn : null,
                      ),
                      const SizedBox(height: P2),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
