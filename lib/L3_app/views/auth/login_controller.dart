// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../_base/base_controller.dart';

part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {}

abstract class _LoginControllerBase extends BaseController with Store {
  @override
  Future fetchData() async {
    startLoading();
    await authUC.setApiCredentialsFromSettings();
    setAuthorized(settingsController.settings?.accessToken.isNotEmpty ?? false);
    stopLoading();
  }

  @observable
  bool authorized = false;

  @action
  void setAuthorized(bool _auth) => authorized = _auth;

  Future authorize(BuildContext context) async {
    startLoading();
    final bool _authorized = await authUC.authorize(username: tfAnnoForCode('login').text, password: tfAnnoForCode('password').text);
    setAuthorized(_authorized);
    stopLoading();

    // TODO: должен быть общий метод где-то в районе extra.dart для этого. В главном контроллере по идее.
    if (_authorized) {
      for (var controller in [
        settingsController,
        mainController,
        goalController,
        trackerController,
      ]) {
        await controller.fetchData();
      }
    } else {
      //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    }
  }

  @action
  Future logout(BuildContext context) async {
    setAuthorized(false);

    // TODO: не очень изящное решение. Может, вызывать clear метод у контроллеров?
    for (var controller in [
      settingsController,
      mainController,
      goalController,
      trackerController,
    ]) {
      await controller.fetchData();
    }

    await authUC.logout();
  }
}
