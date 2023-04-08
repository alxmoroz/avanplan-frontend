// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../extra/services.dart';
import 'legal_links.dart';
import 'sign_in_controller.dart';
import 'sign_in_header.dart';

Future showSignInPasswordDialog(BuildContext context) async {
  return await showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(SignInWithPasswordForm()),
  );
}

class SignInWithPasswordForm extends StatefulWidget {
  @override
  _SignInWithPasswordFormState createState() => _SignInWithPasswordFormState();
}

class _SignInWithPasswordFormState extends State<SignInWithPasswordForm> {
  late SignInController _controller;

  @override
  void initState() {
    _controller = SignInController();
    _controller.initState(tfaList: [
      TFAnnotation('username', label: loc.auth_user_placeholder),
      TFAnnotation('password', label: loc.auth_password_placeholder),
    ]);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) {
    final isPassword = code == 'password';
    return MTTextField(
      controller: _controller.teControllers[code],
      label: _controller.tfAnnoForCode(code).label,
      error: _controller.tfAnnoForCode(code).errorText,
      obscureText: isPassword && _controller.showPassword == false,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !_controller.showPassword), _controller.toggleShowPassword) : null,
      maxLines: 1,
      capitalization: TextCapitalization.none,
    );
  }

  @override
  Widget build(BuildContext context) => MTPage(
        navBar: navBar(context, bgColor: backgroundColor),
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: SCR_S_WIDTH),
              child: LayoutBuilder(
                builder: (_, size) => Observer(
                  builder: (_) => ListView(
                    shrinkWrap: true,
                    children: [
                      SignInHeader(size),
                      textFieldForCode('username'),
                      textFieldForCode('password'),
                      MTButton.outlined(
                        margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
                        titleText: loc.auth_sign_in_action_title,
                        onTap: _controller.validated ? () => _controller.signInWithPassword(context) : null,
                      ),
                      const SizedBox(height: P2),
                      const LegalLinks(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
