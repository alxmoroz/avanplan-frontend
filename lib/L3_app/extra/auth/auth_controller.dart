// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/system/errors.dart';
import '../services.dart';

part 'auth_controller.g.dart';

class AuthController extends _AuthControllerBase with _$AuthController {
  Future<AuthController> init() async {
    await authUC.updateOAuthToken();
    setAuthorized(await authUC.hasLocalAuth);
    signInWithAppleIsAvailable = await authUC.signInAppleIsAvailable();
    await authUC.signInGoogleIsAvailable();
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

  bool? get _invited => deepLinkController.invitationToken?.isNotEmpty;

  String _langCode(BuildContext context) => Localizations.localeOf(context).languageCode;

  Future signInEmail(BuildContext context, String email, String pwd) async {
    loaderController.start();
    loaderController.setAuth();
    setAuthorized(await authUC.signInEmail(email: email, pwd: pwd));
    Navigator.of(context).pop();
    await loaderController.stop();
  }

  Future signInGoogle(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      setAuthorized(await authUC.signInGoogle(_langCode(context), _invited));
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  Future signInApple(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      setAuthorized(await authUC.signInApple(_langCode(context), _invited));
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
}
