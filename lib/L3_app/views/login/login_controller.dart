// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {}

abstract class _LoginControllerBase extends EditController with Store {
  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  Future authorize(BuildContext context) async => await authController.authorize(
        context,
        tfAnnoForCode('login').text,
        tfAnnoForCode('password').text,
      );
}
