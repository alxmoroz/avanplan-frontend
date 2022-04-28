// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../_base/base_controller.dart';
import '../main/main_view.dart';
import 'login_view.dart';

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

    if (_authorized) {
      for (var controller in [
        settingsController,
        mainController,
        workspaceController,
        goalController,
        taskEditController,
        trackerController,
      ]) {
        await controller.fetchData();
      }

      /// навигация
      await Navigator.of(context).pushReplacementNamed(MainView.routeName);
    } else {
      //TODO: не учитываются возможные ошибки! Нет обработки 403 и т.п.
    }
    stopLoading();
  }

  @action
  Future logout(BuildContext context) async {
    // TODO: нужно чистить данные из памяти контроллеров.

    await authUC.logout();
    Navigator.of(context).pushReplacementNamed(LoginView.routeName);
  }
}
