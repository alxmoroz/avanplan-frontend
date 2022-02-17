// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/usecases/auth_uc.dart';
import '../../extra/services.dart';
import '../base/base_controller.dart';

part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {
  @override
  Future<LoginController> init() async => this;
}

abstract class _LoginControllerBase extends BaseController with Store {
  Future authorize() async {
    //TODO: тут должен быть экшен из контроллера, иначе ниже не обновляется компьютед
    //TODO: перенести куда положено всё это
    await mainController.settings.authorize(
      username: tfAnnoForCode('login').text,
      password: tfAnnoForCode('password').text,
    );

    //TODO: не учитываются возможные ошибки!
    //TODO: тут должен быть компьютед из контроллера (после создания нормального экшена выше)
    if (mainController.settings.accessToken.isNotEmpty) {
      mainController.setAuthorized(true);

      /// навигация
      Navigator.of(context!).pop();
    }
  }
}
