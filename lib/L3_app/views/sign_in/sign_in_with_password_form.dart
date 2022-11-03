// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L2_data/repositories/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_bottom_sheet.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../components/text_field_annotation.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'sign_in_controller.dart';
import 'sign_in_terms_links.dart';

Future<String?> showSignInPasswordDialog(BuildContext context) async {
  return await showModalBottomSheet<String?>(
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

  bool get _hasFocus => FocusScope.of(context).hasFocus;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, bgColor: backgroundColor),
        body: SafeArea(
          child: Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: onePadding * (_hasFocus && !isWeb ? 5 : 14),
                  child: gerculesIcon(),
                ),
                H1(loc.app_title, align: TextAlign.center),
                textFieldForCode('username'),
                textFieldForCode('password'),
                MTButton.outlined(
                  margin: EdgeInsets.symmetric(horizontal: onePadding * 4).copyWith(top: onePadding * 2),
                  titleText: loc.auth_sign_in_action_title,
                  onTap: _controller.validated ? () => _controller.signInWithPassword(context) : null,
                ),
                SizedBox(height: onePadding * 2),
                const SignInTermsLinks(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
