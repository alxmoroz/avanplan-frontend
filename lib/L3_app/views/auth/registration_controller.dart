// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/registration.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_field_data.dart';
import '../../components/mt_text_field.dart';
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
  Widget tf(String code, {bool first = false}) {
    final isPassword = code == 'password';
    final isEmail = code == 'email';
    return MTTextField(
      controller: teControllers[code],
      label: fData(code).label,
      error: fData(code).errorText,
      obscureText: isPassword && _showPassword == false,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !_showPassword), _toggleShowPassword) : null,
      maxLines: 1,
      capitalization: TextCapitalization.none,
      margin: tfPadding.copyWith(top: first ? P_2 : tfPadding.top),
    );
  }

  @observable
  bool _showPassword = false;

  @action
  void _toggleShowPassword() => _showPassword = !_showPassword;

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
