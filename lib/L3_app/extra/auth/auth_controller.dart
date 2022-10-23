// Copyright (c) 2022. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/ws_role.dart';
import '../../../L1_domain/system/errors.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
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

  Widget get _loaderIcon => PrivacyIcon(size: onePadding * 10, color: lightGreyColor);

  void _catchAuthError(BuildContext context) {
    loaderController.setLoader(
      context,
      icon: _loaderIcon,
      titleText: loc.auth_error_title,
      descriptionText: loc.auth_error_description,
      actionText: loc.ok,
    );
  }

  void _catchGoogleAuthError(BuildContext context, MTException e) {
    // TODO: можно определять что именно произошло по типу кода и выдавать соотв. сообщение
    loaderController.setLoader(context, icon: _loaderIcon, titleText: e.code, actionText: loc.ok);
  }

  Future authorize(BuildContext context, String login, String password) async {
    loaderController.setLoader(context, icon: _loaderIcon, titleText: 'AUTH');
    try {
      _setAuthorized(await authUC.authorize(username: login, password: password));
      loaderController.hideLoader();
    } catch (_) {
      _catchAuthError(context);
    }
  }

  Future authorizeWithGoogle(BuildContext context) async {
    loaderController.setLoader(context, icon: _loaderIcon, titleText: 'G_AUTH');
    try {
      _setAuthorized(await authUC.authorizeWithGoogle());
      loaderController.hideLoader();
    } on MTException catch (e) {
      _catchGoogleAuthError(context, e);
    } catch (_) {
      _catchAuthError(context);
    }
  }

  Future logout() async {
    _setAuthorized(false);
    await authUC.logout();
  }

  bool canEditWS(Iterable<WSRole> roles) => roles.firstWhereOrNull((r) => r.title == 'admin') != null;
}
