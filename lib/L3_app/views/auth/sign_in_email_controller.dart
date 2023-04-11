// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'sign_in_email_controller.g.dart';

class SignInEmailController extends _SignInEmailControllerBase with _$SignInEmailController {}

abstract class _SignInEmailControllerBase extends EditController with Store {
  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  Future signIn(BuildContext context) async => await authController.signInWithPassword(
        context,
        tfAnnoForCode('email').text,
        tfAnnoForCode('password').text,
      );
}
