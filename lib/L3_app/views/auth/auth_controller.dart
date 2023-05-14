// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/system/errors.dart';
import '../../extra/services.dart';
import '../../presenters/loader_presenter.dart';

part 'auth_controller.g.dart';

class AuthController extends _AuthControllerBase with _$AuthController {
  Future<AuthController> init() async {
    await authUC.updateOAuthToken();
    authorized = await authUC.hasLocalAuth;
    signInWithAppleIsAvailable = await authUC.appleIsAvailable();
    await authUC.googleIsAvailable();
    return this;
  }
}

abstract class _AuthControllerBase with Store {
  @observable
  bool signInWithAppleIsAvailable = false;

  @observable
  bool authorized = false;

  @observable
  bool registerMode = false;

  @action
  void toggleRegisterMode() => registerMode = !registerMode;

  @action
  Future _signInWithRegistration() async {
    if (deepLinkController.hasRegistration) {
      await signOut();
      _startLdrAuth();
      authorized = await authUC.signInWithRegistration(deepLinkController.registrationToken!);
      deepLinkController.clearRegistration();
      await loader.stop();
    }
  }

  @action
  Future signInWithPassword(String email, String pwd) async {
    _startLdrAuth();
    authorized = await authUC.signInWithPassword(email, pwd);
    Navigator.of(rootKey.currentContext!).pop();
    await loader.stop();
  }

  @action
  Future signInGoogle() async {
    _startLdrAuth();
    try {
      authorized = await authUC.signInGoogle();
      await loader.stop();
    } on MTOAuthError catch (e) {
      loader.setAuthError(e.detail);
    }
  }

  @action
  Future signInApple() async {
    _startLdrAuth();
    try {
      authorized = await authUC.signInApple();
      await loader.stop();
    } on MTOAuthError catch (e) {
      loader.setAuthError(e.detail);
    }
  }

  @action
  Future updateAuth() async {
    authorized = await authUC.hasLocalAuth;
    if (await authUC.needRefreshAuth()) {
      _startLdrAuth();
      authorized = await authUC.refreshAuth();
      await loader.stop();
    }
  }

  @action
  Future signOut() async {
    Navigator.of(rootKey.currentContext!).popUntil((r) => r.navigator?.canPop() == false);
    authorized = false;
    await authUC.signOut();
  }

  bool _startupActionsInProgress = false;
  Future startupActions() async {
    if (!_startupActionsInProgress) {
      _startupActionsInProgress = true;
      await _signInWithRegistration();
    }
    _startupActionsInProgress = false;
  }

  void _startLdrAuth() {
    loader.start();
    loader.set(titleText: loc.loader_auth_title, icon: ldrAuthIcon);
  }
}
