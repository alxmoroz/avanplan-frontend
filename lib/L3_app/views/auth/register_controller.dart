// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'register_controller.g.dart';

class RegisterController extends _RegisterControllerBase with _$RegisterController {}

abstract class _RegisterControllerBase extends EditController with Store {
  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @observable
  bool registerCompleted = false;

  @action
  Future register(BuildContext context) async {
    loaderController.start();
    loaderController.setSaving();
    registerCompleted = await authUC.register(
      name: tfAnnoForCode('name').text,
      email: tfAnnoForCode('email').text,
      pwd: tfAnnoForCode('password').text,
      locale: Localizations.localeOf(context).languageCode,
    );
    await loaderController.stop();
  }
}
