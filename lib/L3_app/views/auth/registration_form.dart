// Copyright (c) 2023. Alexandr Moroz

import 'package:avanplan/L3_app/components/mt_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/mt_dialog.dart';
import '../../extra/services.dart';
import 'registration_completed_message.dart';
import 'registration_controller.dart';

Future registrationDialog() async => await showMTDialog<void>(RegistrationForm());

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

  @override
  Widget build(BuildContext context) => MTDialog(
        topBar: MTTopBar(titleText: loc.auth_register_title),
        body: Observer(
          builder: (_) => controller.requestCompleted
              ? RegistrationCompletedMessage(controller: controller)
              : ListView(
                  shrinkWrap: true,
                  children: [
                    controller.tf('name', first: true),
                    controller.tf('email'),
                    controller.tf('password'),
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
