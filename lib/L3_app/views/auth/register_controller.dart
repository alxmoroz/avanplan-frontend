// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/registration.dart';
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
    registerCompleted = await authUC.requestRegistration(
      Registration(tfAnnoForCode('name').text, tfAnnoForCode('email').text, Localizations.localeOf(context).languageCode,
          invitationToken: deepLinkController.invitationToken),
      tfAnnoForCode('password').text,
    );
    await loaderController.stop();
  }
}
