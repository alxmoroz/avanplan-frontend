// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/ws_role.dart';
import '../../../L1_domain/system/errors.dart';
import '../services.dart';

part 'auth_controller.g.dart';

class AuthController extends _AuthControllerBase with _$AuthController {
  Future<AuthController> init() async {
    await authUC.setApiCredentialsFromLocalAuth();
    _setAuthorized(await authUC.isLocalAuthorized());
    authWithAppleIsAvailable = await authUC.authWithAppleIsAvailable();
    return this;
  }
}

abstract class _AuthControllerBase with Store {
  @observable
  bool authorized = false;

  @action
  void _setAuthorized(bool _auth) => authorized = _auth;

  Future authorize(BuildContext context, String login, String password) async {
    loaderController.start();
    loaderController.setAuth();
    _setAuthorized(await authUC.authorize(username: login, password: password));
    await loaderController.stop();
  }

  Future authorizeWithGoogle(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      _setAuthorized(await authUC.authorizeWithGoogle());
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  @observable
  bool authWithAppleIsAvailable = false;

  Future authorizeWithApple(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      _setAuthorized(await authUC.authorizeWithApple());
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  Future logout() async {
    _setAuthorized(false);
    await authUC.logout();
  }

  bool canEditWS(Iterable<WSRole> roles) => roles.firstWhereOrNull((r) => r.title == 'admin') != null;
}
