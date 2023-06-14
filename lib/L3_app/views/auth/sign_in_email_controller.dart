// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_field_data.dart';
import '../../components/mt_text_field.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'sign_in_email_controller.g.dart';

class SignInEmailController extends _SignInEmailControllerBase with _$SignInEmailController {
  SignInEmailController() {
    initState(fds: [
      MTFieldData('email', label: loc.auth_email_placeholder),
      MTFieldData('password', label: loc.auth_password_placeholder),
    ]);
  }
}

abstract class _SignInEmailControllerBase extends EditController with Store {
  Widget tf(String code) {
    final isPassword = code == 'password';
    final isEmail = code == 'email';
    return MTTextField(
      controller: teControllers[code],
      label: fData(code).label,
      error: fData(code).errorText,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      obscureText: isPassword && _showPassword == false,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !_showPassword), _toggleShowPassword) : null,
      maxLines: 1,
      capitalization: TextCapitalization.none,
    );
  }

  @observable
  bool _showPassword = false;

  @action
  void _toggleShowPassword() => _showPassword = !_showPassword;

  Future signIn() async => await authController.signInWithPassword(
        fData('email').text,
        fData('password').text,
      );
}
