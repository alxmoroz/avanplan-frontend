// Copyright (c) 2024. Alexandr Moroz

import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/errors.dart';
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

  @action
  Future _signInWithRegistration() async {
    if (registrationTokenController.hasToken) {
      _startLdrAuth();
      final token = registrationTokenController.token!;
      registrationTokenController.clear();
      if (authorized) await authUC.signOut();

      authorized = await authUC.signInWithRegistration(token);
      if (authorized) goRouter.goMain();
      loader.stop();
    }
  }

  @action
  Future signInWithPassword(String email, String pwd) async {
    _startLdrAuth();
    authorized = await authUC.signInWithPassword(email, pwd);
    if (authorized) goRouter.goMain();
    loader.stop();
  }

  @action
  Future signInGoogle() async {
    _startLdrAuth();
    try {
      authorized = await authUC.signInGoogle();
      if (authorized) goRouter.goMain();
      loader.stop();
    } on MTOAuthError catch (e) {
      loader.setAuthError(e.description);
    }
  }

  @action
  Future signInApple() async {
    _startLdrAuth();
    try {
      authorized = await authUC.signInApple();
      if (authorized) goRouter.goMain();
      loader.stop();
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
      loader.stop();
    }
    authorized = hasToken;
  }

  @action
  Future signOut() async {
    authorized = false;
    loader.start();
    await authUC.signOut();
    loader.stop();
    goRouter.goAuth();
  }

  Future startupActions() async {
    print('AuthController startupActions');
    await appController.initState();
    await _signInWithRegistration();
  }

  void _startLdrAuth() {
    loader.set(imageName: ImageName.privacy.name, titleText: loc.loader_auth_title);
    loader.start();
  }
}
