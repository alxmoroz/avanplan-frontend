// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_field_data.dart';
import '../../components/mt_text_field.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'sign_in_email_controller.g.dart';

enum SigninFCode { name, email, password }

class SignInEmailController extends _SignInEmailControllerBase with _$SignInEmailController {
  SignInEmailController() {
    initState(fds: [
      MTFieldData(SigninFCode.email.index, label: loc.auth_email_placeholder, validate: true),
      MTFieldData(SigninFCode.password.index, label: loc.auth_password_placeholder, validate: true),
    ]);
  }
}

abstract class _SignInEmailControllerBase extends EditController with Store {
  Widget tf(SigninFCode code, {bool first = false}) {
    final fd = fData(code.index);
    final isPassword = code == SigninFCode.password;
    final isEmail = code == SigninFCode.email;
    return MTTextField(
      controller: teController(code.index),
      label: fd.label,
      error: fd.errorText,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      obscureText: isPassword && _showPassword == false,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !_showPassword), onTap: _toggleShowPassword) : null,
      maxLines: 1,
      capitalization: TextCapitalization.none,
      margin: tfPadding.copyWith(top: first ? P_2 : tfPadding.top),
    );
  }

  @observable
  bool _showPassword = false;

  @action
  void _toggleShowPassword() => _showPassword = !_showPassword;

  Future signIn() async => await authController.signInWithPassword(
        fData(SigninFCode.email.index).text,
        fData(SigninFCode.password.index).text,
      );
}
