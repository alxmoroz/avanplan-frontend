// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:dio/dio.dart';
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
    return this;
  }
}

abstract class _AuthControllerBase with Store {
  @observable
  bool authorized = false;

  @action
  void _setAuthorized(bool _auth) => authorized = _auth;

  Future authorize(BuildContext context, String login, String password) async {
    loaderController.setLoader(context, icon: loaderController.authIcon, titleText: 'AUTH');
    try {
      _setAuthorized(await authUC.authorize(username: login, password: password));
      loaderController.hideLoader();
    } on DioError catch (e) {
      print(e);
    }
  }

  Future authorizeWithGoogle(BuildContext context) async {
    loaderController.setLoader(context, icon: loaderController.authIcon, titleText: 'G_AUTH');
    try {
      _setAuthorized(await authUC.authorizeWithGoogle());
      loaderController.hideLoader();
    } on MTOAuthError catch (e) {
      // TODO: можно определять что именно произошло по типу кода и выдавать соотв. сообщение
      loaderController.setLoader(context, icon: loaderController.authIcon, titleText: e.code, actionText: loc.ok);
    } on DioError catch (e) {
      print(e);
    }
  }

  Future logout() async {
    _setAuthorized(false);
    await authUC.logout();
  }

  bool canEditWS(Iterable<WSRole> roles) => roles.firstWhereOrNull((r) => r.title == 'admin') != null;
}
