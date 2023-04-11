// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/system/errors.dart';
import '../../extra/services.dart';

part 'auth_controller.g.dart';

class AuthController extends _AuthControllerBase with _$AuthController {
  Future<AuthController> init() async {
    await authUC.updateOAuthToken();
    setAuthorized(await authUC.hasLocalAuth);
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

  @action
  void setAuthorized(bool _auth) => authorized = _auth;

  String _langCode(BuildContext context) => Localizations.localeOf(context).languageCode;

  @observable
  bool registerMode = false;

  @action
  void toggleRegisterMode() => registerMode = !registerMode;

  Future signInEmail(BuildContext context, String email, String pwd) async {
    loaderController.start();
    loaderController.setAuth();
    setAuthorized(await authUC.signInAvanplan(email, pwd));
    Navigator.of(context).pop();
    await loaderController.stop();
  }

  Future signInGoogle(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      setAuthorized(await authUC.signInGoogle(_langCode(context)));
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  Future signInApple(BuildContext context) async {
    loaderController.start();
    loaderController.setAuth();
    try {
      setAuthorized(await authUC.signInApple(_langCode(context)));
      await loaderController.stop();
    } on MTOAuthError catch (e) {
      loaderController.setAuthError(e.detail);
    }
  }

  Future updateAuth() async {
    loaderController.start();
    loaderController.setAuth();
    setAuthorized(await authUC.refreshAuth());
    await loaderController.stop();
  }

  Future signOut() async {
    setAuthorized(false);
    await authUC.signOut();
  }

  Future<bool> redeemInvitation() async {
    bool invited = false;
    if (deepLinkController.hasInvitation) {
      loaderController.start();
      loaderController.setRedeemInvitation();
      invited = await invitationUC.redeem(deepLinkController.invitationToken!);
      await loaderController.stop();
    }
    return invited;
  }

  Future<bool> redeemEmailRegistration() async {
    bool authorized = false;
    if (deepLinkController.hasRegistration) {
      loaderController.start();
      loaderController.setAuth();
      final authToken = await registrationUC.redeem(deepLinkController.registrationToken!);
      if (authToken.isNotEmpty) {
        authorized = await authUC.signInWithToken(authToken);
      }
      await loaderController.stop();
      deepLinkController.clearRegistration();
    }
    return authorized;
  }
}
