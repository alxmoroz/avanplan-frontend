// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/registration.dart';
import '../../components/mt_field_data.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'registration_controller.g.dart';

class RegistrationController extends _RegistrationControllerBase with _$RegistrationController {
  RegistrationController() {
    initState(fds: [
      MTFieldData('name', label: loc.auth_name_placeholder),
      MTFieldData('email', label: loc.auth_email_placeholder),
      MTFieldData('password', label: loc.auth_password_placeholder),
    ]);
  }
}

abstract class _RegistrationControllerBase extends EditController with Store {
  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @observable
  bool requestCompleted = false;

  @action
  Future createRequest(BuildContext context) async {
    loader.start();
    loader.setSaving();
    final regRequest = RegistrationRequest(
      fData('name').text,
      fData('email').text,
      invitationToken: deepLinkController.invitationToken,
    );
    requestCompleted = await authUC.requestRegistration(regRequest, fData('password').text);
    await loader.stop();
  }
}
