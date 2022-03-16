// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../main/main_view.dart';

part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {}

abstract class _LoginControllerBase extends BaseController with Store {
  Future authorize() async {
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.

    if (await authUC.authorize(
      username: tfAnnoForCode('login').text,
      password: tfAnnoForCode('password').text,
    )) {
      /// навигация
      await Navigator.of(context!).pushReplacementNamed(MainView.routeName);
    }
  }
}
