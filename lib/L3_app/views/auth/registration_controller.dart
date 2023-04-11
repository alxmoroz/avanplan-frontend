// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/registration.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'registration_controller.g.dart';

class RegistrationController extends _RegistrationControllerBase with _$RegistrationController {}

abstract class _RegistrationControllerBase extends EditController with Store {
  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @observable
  bool requestCompleted = false;

  @action
  Future createRequest(BuildContext context) async {
    loaderController.start();
    loaderController.setSaving();
    final regRequest = RegistrationRequest(
      tfAnnoForCode('name').text,
      tfAnnoForCode('email').text,
      Localizations.localeOf(context).languageCode,
      invitationToken: deepLinkController.invitationToken,
    );
    requestCompleted = await authUC.requestRegistration(regRequest, tfAnnoForCode('password').text);
    await loaderController.stop();
  }
}
