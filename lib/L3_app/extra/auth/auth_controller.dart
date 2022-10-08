// Copyright (c) 2022. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../services.dart';

part 'auth_controller.g.dart';

class AuthController extends _AuthControllerBase with _$AuthController {
  Future<AuthController> init() async {
    await authUC.setApiCredentialsFromLocalAuth();
    _setAuthorized(await authUC.isLocalAuthorized());
    return this;
  }
}

abstract class _AuthControllerBase with Store {
  @observable
  bool authorized = false;

  @action
  void _setAuthorized(bool _auth) => authorized = _auth;

  @action
  Future authorize(String login, String password) async {
    _setAuthorized(await authUC.authorize(
      username: login,
      password: password,
    ));
  }

  Future logout() async {
    _setAuthorized(false);
    await authUC.logout();
  }
}
