// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/system/errors.dart';
import '../../components/mt_confirm_dialog.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'login_controller.g.dart';

class LoginController extends _LoginControllerBase with _$LoginController {}

abstract class _LoginControllerBase extends EditController with Store {
  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  Future _parseException(BuildContext context, Object e) async {
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

  Future authorize(BuildContext context) async {
    startLoading();
    try {
      await authController.authorize(tfAnnoForCode('login').text, tfAnnoForCode('password').text);
    } catch (e) {
      await _parseException(context, e);
    }
    stopLoading();
  }

  Future authorizeWithGoogle(BuildContext context) async {
    startLoading();
    try {
      await authController.authorizeWithGoogle();
    } catch (e) {
      await _parseException(context, e);
    }
    stopLoading();
  }
}
