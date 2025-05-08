// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';

import '../../../L1_domain/entities/registration.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/field_data.dart';
import '../../components/icons.dart';
import '../../components/text_field.dart';
import '../../theme/colors.dart';
import '../_base/edit_controller.dart';
import '../_base/loadable.dart';
import '../app/services.dart';

part 'registration_request_controller.g.dart';

enum RegistrationFCode { name, email, password }

class RegistrationRequestController extends _RegistrationControllerBase with _$RegistrationRequestController {
  RegistrationRequestController() {
    initState(fds: [
      MTFieldData(RegistrationFCode.name.index, label: loc.auth_name_placeholder, validate: true),
      MTFieldData(RegistrationFCode.email.index, label: loc.auth_email_placeholder, validate: true),
      MTFieldData(RegistrationFCode.password.index, label: loc.auth_password_placeholder, validate: true),
    ]);
    stopLoading();
    setLoaderScreenSaving();
  }
}

abstract class _RegistrationControllerBase extends EditController with Store, Loadable {
  Widget tf(RegistrationFCode code, {bool first = false}) {
    final isPassword = code == RegistrationFCode.password;
    final isEmail = code == RegistrationFCode.email;
    final fd = fData(code.index);
    return MTTextField(
      controller: teController(code.index),
      label: fd.label,
      error: fd.errorText,
      suggestions: false,
      autocorrect: false,
      obscureText: isPassword && _showPassword == false,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !_showPassword, color: mainColor), onTap: _toggleShowPassword, uf: false) : null,
      maxLines: 1,
      capitalization: TextCapitalization.none,
      margin: tfMargin.copyWith(top: first ? P : tfMargin.top),
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
    await load(() async {
      final regRequest = RegistrationRequest(
        fData(RegistrationFCode.name.index).text,
        fData(RegistrationFCode.email.index).text,
        invitationToken: localSettingsController.invitationToken,
      );
      requestCompleted = await authUC.requestRegistration(regRequest, fData(RegistrationFCode.password.index).text);
      if (requestCompleted && localSettingsController.hasInvitation) {
        await localSettingsController.deleteInvitationToken();
      }
    });
  }
}
