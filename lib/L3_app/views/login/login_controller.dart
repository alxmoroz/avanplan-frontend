// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/system/errors.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {
  Future<LoginController> init() async {
    await authUC.setApiCredentialsFromLocalAuth();
    _setAuthorized(await authUC.isLocalAuthorized());
    return this;
  }
}

abstract class _LoginControllerBase extends EditController with Store {
  @observable
  bool authorized = false;

  @action
  Future _setAuthorized(bool _auth) async => authorized = _auth;

  Future authorize(BuildContext context) async {
    startLoading();
    try {
      _setAuthorized(await authUC.authorize(
        username: tfAnnoForCode('login').text,
        password: tfAnnoForCode('password').text,
      ));
    } catch (e) {
      stopLoading();
      // TODO: можно определять что именно произошло по типу кода и выдавать соотв. сообщение
      final eCode = e is MTException && e.code != '403' ? ' ${e.code}' : '';
      await showMTDialog<void>(
        context,
        title: '${loc.auth_error_title}$eCode',
        description: loc.auth_error_description,
        actions: [MTDialogAction(title: loc.ok, result: null, type: MTActionType.isDefault)],
        simple: true,
      );
    }

    stopLoading();
  }

  Future logout() async {
    await _setAuthorized(false);
    await authUC.logout();
  }
}
