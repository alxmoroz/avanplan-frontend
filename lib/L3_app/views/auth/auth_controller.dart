// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/errors.dart';
import '../../../main.dart';
import '../../components/images.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';

part 'auth_controller.g.dart';

class AuthController extends _AuthControllerBase with _$AuthController {
  Future<AuthController> init() async {
    signInWithAppleIsAvailable = await authUC.appleIsAvailable();
    await authUC.googleIsAvailable();

    authorized = (await authUC.getLocalAuth()).hasToken;

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
    if (registrationTokenController.hasToken) {
      await signOut();
      _startLdrAuth();
      authorized = await authUC.signInWithRegistration(registrationTokenController.token!);
      registrationTokenController.clear();
      await loader.stop(300);
    }
  }

  @action
  Future signInWithPassword(String email, String pwd) async {
    _startLdrAuth();
    authorized = await authUC.signInWithPassword(email, pwd);
    Navigator.of(rootKey.currentContext!).pop();
    await loader.stop(300);
  }

  @action
  Future signInGoogle() async {
    _startLdrAuth();
    try {
      authorized = await authUC.signInGoogle();
      await loader.stop(300);
    } on MTOAuthError catch (e) {
      loader.setAuthError(e.description);
    }
  }

  @action
  Future signInApple() async {
    _startLdrAuth();
    try {
      authorized = await authUC.signInApple();
      await loader.stop(300);
    } on MTOAuthError catch (e) {
      loader.setAuthError(e.description);
    }
  }

  @action
  Future checkLocalAuth() async {
    final localAuth = await authUC.getLocalAuth();
    bool hasToken = localAuth.hasToken;
    if (hasToken && localAuth.needRefresh) {
      _startLdrAuth();
      hasToken = await authUC.refreshToken();
      await loader.stop();
    }
    authorized = hasToken;
  }

  @action
  Future signOut() async {
    popTop();
    authorized = false;
    await authUC.signOut();
  }

  Future startupActions() async {
    await _signInWithRegistration();
    loader.stopInit();
  }

  void _startLdrAuth() {
    loader.set(imageName: ImageName.privacy.name, titleText: loc.loader_auth_title);
    loader.start();
  }
}
