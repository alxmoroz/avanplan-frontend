// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../base/base_controller.dart';

part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {}

abstract class _LoginControllerBase extends BaseController with Store {
  Future authorize() async {
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    final token = await authUC.authorize(
      username: tfAnnoForCode('login').text,
      password: tfAnnoForCode('password').text,
    );

    if (token.isNotEmpty) {
      /// навигация
      Navigator.of(context!).pop();
    }
  }
}
