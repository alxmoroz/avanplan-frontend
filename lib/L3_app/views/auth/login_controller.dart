// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {
  Future<LoginController> init() async {
    await authUC.setApiCredentialsFromLocalAuth();
    _setAuthorized(await authUC.isLocalAuthorized());
    return this;
  }
}

abstract class _LoginControllerBase extends EditController with Store {
  @observable
  bool authorized = false;

  @action
  Future _setAuthorized(bool _auth) async => authorized = _auth;

  Future authorize() async {
    startLoading();
    //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    _setAuthorized(await authUC.authorize(
      username: tfAnnoForCode('login').text,
      password: tfAnnoForCode('password').text,
    ));
    stopLoading();
  }

  Future logout() async {
    await _setAuthorized(false);
    await authUC.logout();
  }
}
