// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'sign_in_controller.g.dart';

class SignInController extends _SignInControllerBase with _$SignInController {}

abstract class _SignInControllerBase extends EditController with Store {
  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  Future signInPassword(BuildContext context) async => await authController.signInPassword(
        context,
        tfAnnoForCode('username').text,
        tfAnnoForCode('password').text,
      );
}
