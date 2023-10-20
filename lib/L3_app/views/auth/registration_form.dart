// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
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
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTDialog(
          topBar: MTTopBar(titleText: controller.requestCompleted ? loc.register_completed_title : loc.register_title),
          body: controller.requestCompleted
              ? RegistrationCompletedMessage(controller)
              : ListView(
                  shrinkWrap: true,
                  children: [
                    controller.tf(RegistrationFCode.name, first: true),
                    controller.tf(RegistrationFCode.email),
                    controller.tf(RegistrationFCode.password),
                    const SizedBox(height: P4),
                    MTButton.main(
                      titleText: loc.register_action_title,
                      onTap: controller.validated ? () => controller.createRequest(context) : null,
                    ),
                  ],
                ),
        ),
      );
}
