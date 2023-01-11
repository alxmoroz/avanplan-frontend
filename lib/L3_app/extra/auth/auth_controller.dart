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
    await authUC.updateOAuthToken();
    setAuthorized(await authUC.hasLocalAuth);
    signInWithAppleIsAvailable = await authUC.signInWithAppleIsAvailable();
    await authUC.signInWithGoogleIsAvailable();
    return this;
  }
}

abstract class _AuthControllerBase with Store {
  @observable
  bool signInWithAppleIsAvailable = false;

  @observable
  bool authorized = false;

  @action
  void setAuthorized(bool _auth) => authorized = _auth;

  String _langCode(BuildContext context) => Localizations.localeOf(context).languageCode;

  Future signInWithPassword(BuildContext context, String login, String pwd) async {
    loaderController.start();
    loaderController.setAuth();
    setAuthorized(await authUC.signInWithPassword(login: login, pwd: pwd));
    Navigator.of(context).pop();
    await loaderController.stop();
  }

  Future signInWithGoogle(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      setAuthorized(await authUC.signInWithGoogle(_langCode(context)));
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  Future signInWithApple(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      setAuthorized(await authUC.signInWithApple(_langCode(context)));
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  Future updateAuth(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    setAuthorized(await authUC.refreshAuth());
    await loaderController.stop();
  }

  Future signOut() async {
    setAuthorized(false);
    await authUC.signOut();
  }

  bool canEditWS(Iterable<WSRole> roles) => roles.firstWhereOrNull((r) => r.code == 'admin') != null;
}
