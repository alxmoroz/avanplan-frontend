// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/registration.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/field_data.dart';
import '../../components/icons.dart';
import '../../components/text_field.dart';
import '../../extra/services.dart';
import '../_base/edit_controller.dart';

part 'registration_controller.g.dart';

enum RegistrationFCode { name, email, password }

class RegistrationController extends _RegistrationControllerBase with _$RegistrationController {
  RegistrationController() {
    initState(fds: [
      MTFieldData(RegistrationFCode.name.index, label: loc.auth_name_placeholder, validate: true),
      MTFieldData(RegistrationFCode.email.index, label: loc.auth_email_placeholder, validate: true),
      MTFieldData(RegistrationFCode.password.index, label: loc.auth_password_placeholder, validate: true),
    ]);
  }
}

abstract class _RegistrationControllerBase extends EditController with Store {
  Widget tf(RegistrationFCode code, {bool first = false}) {
    final isPassword = code == RegistrationFCode.password;
    final isEmail = code == RegistrationFCode.email;
    final fd = fData(code.index);
    return MTTextField(
      controller: teController(code.index),
      label: fd.label,
      error: fd.errorText,
      obscureText: isPassword && _showPassword == false,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !_showPassword, color: mainColor), onTap: _toggleShowPassword) : null,
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
      fData(RegistrationFCode.name.index).text,
      fData(RegistrationFCode.email.index).text,
      invitationToken: deepLinkController.invitationToken,
    );
    requestCompleted = await authUC.requestRegistration(regRequest, fData(RegistrationFCode.password.index).text);
    await loader.stop();
  }
}
