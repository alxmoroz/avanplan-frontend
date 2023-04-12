// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/system/errors.dart';
import '../../extra/services.dart';

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

  String _langCode(BuildContext context) => Localizations.localeOf(context).languageCode;

  @observable
  bool registerMode = false;

  @action
  void toggleRegisterMode() => registerMode = !registerMode;

  @action
  Future _signInWithRegistration() async {
    if (deepLinkController.hasRegistration) {
      loaderController.start();
      loaderController.setAuth();
      authorized = await authUC.signInWithRegistration(deepLinkController.registrationToken!);
      deepLinkController.clearRegistration();
      await loaderController.stop();
    }
  }

  @action
  Future signInWithPassword(BuildContext context, String email, String pwd) async {
    loaderController.start();
    loaderController.setAuth();
    authorized = await authUC.signInWithPassword(email, pwd);
    Navigator.of(context).pop();
    await loaderController.stop();
  }

  @action
  Future signInGoogle(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      authorized = await authUC.signInGoogle(_langCode(context));
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  @action
  Future signInApple(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      authorized = await authUC.signInApple(_langCode(context));
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  @action
  Future updateAuth() async {
    loaderController.start();
    loaderController.setAuth();
    authorized = await authUC.refreshAuth();
    await loaderController.stop();
  }

  @action
  Future signOut() async {
    authorized = false;
    await authUC.signOut();
  }

  @observable
  bool _startupActionsInProgress = false;

  @action
  Future startupActions() async {
    if (!_startupActionsInProgress) {
      _startupActionsInProgress = true;
      await _signInWithRegistration();
    }
    _startupActionsInProgress = false;
  }
}
