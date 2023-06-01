// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/components/mt_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_close_button.dart';
import '../../components/mt_text_field.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'registration_completed_message.dart';
import 'registration_controller.dart';

Future registrationDialog() async {
  return await showModalBottomSheet<void>(
    context: rootKey.currentContext!,
    isScrollControlled: true,
    builder: (_) => RegistrationForm(),
  );
}

class RegistrationForm extends StatefulWidget {
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  late final RegistrationController controller;

  @override
  void initState() {
    controller = RegistrationController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget textFieldForCode(String code) {
    final isPassword = code == 'password';
    final isEmail = code == 'email';
    return MTTextField(
      controller: controller.teControllers[code],
      label: controller.tfAnnoForCode(code).label,
      error: controller.tfAnnoForCode(code).errorText,
      obscureText: isPassword && controller.showPassword == false,
      keyboardType: isEmail ? TextInputType.emailAddress : null,
      suffixIcon: isPassword ? MTButton.icon(EyeIcon(open: !controller.showPassword), controller.toggleShowPassword) : null,
      maxLines: 1,
      capitalization: TextCapitalization.none,
    );
  }

  @override
  Widget build(BuildContext context) => MTBottomSheet(
        topBar: navBar(
          context,
          leading: MTCloseButton(),
          title: loc.auth_register_title,
          bgColor: backgroundColor,
        ),
        body: Observer(
          builder: (_) => controller.requestCompleted
              ? RegistrationCompletedMessage(controller: controller)
              : ListView(
                  shrinkWrap: true,
                  children: [
                    textFieldForCode('name'),
                    textFieldForCode('email'),
                    textFieldForCode('password'),
                    const SizedBox(height: P2),
                    MTButton.main(
                      titleText: loc.auth_register_action_title,
                      onTap: controller.validated ? () => controller.createRequest(context) : null,
                    ),
                  ],
                ),
        ),
      );
}
