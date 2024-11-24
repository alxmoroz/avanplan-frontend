// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../views/_base/loader_screen.dart';
import 'registration_completed_message.dart';
import 'registration_request_controller.dart';

Future registrationDialog() async => await showMTDialog(const _RegistrationDialog());

class _RegistrationDialog extends StatefulWidget {
  const _RegistrationDialog();

  @override
  State<StatefulWidget> createState() => _RegistrationDialogState();
}

class _RegistrationDialogState extends State<_RegistrationDialog> {
  late final RegistrationRequestController controller;

  @override
  void initState() {
    controller = RegistrationRequestController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => controller.loading
            ? LoaderScreen(controller, isDialog: true)
            : MTDialog(
                topBar: MTTopBar(pageTitle: controller.requestCompleted ? loc.register_completed_title : loc.register_title),
                body: controller.requestCompleted
                    ? RegistrationCompletedMessage(controller)
                    : ListView(
                        shrinkWrap: true,
                        children: [
                          controller.tf(RegistrationFCode.name, first: true),
                          controller.tf(RegistrationFCode.email),
                          controller.tf(RegistrationFCode.password),
                          const SizedBox(height: P3),
                          MTButton.main(
                            titleText: loc.register_action_title,
                            onTap: controller.validated ? () => controller.createRequest(context) : null,
                          ),
                        ],
                      ),
                forceBottomPadding: true,
                hasKBInput: true,
              ),
      );
}
