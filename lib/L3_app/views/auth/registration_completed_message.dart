// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L2_data/repositories/communications_repo.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_button.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/communications_presenter.dart';
import 'registration_controller.dart';

class RegistrationCompletedMessage extends StatelessWidget {
  const RegistrationCompletedMessage({
    required this.controller,
  });

  final RegistrationController controller;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        H3(loc.auth_register_completed_title, align: TextAlign.center),
        const SizedBox(height: P2),
        H4(
          loc.auth_register_completed_description(controller.tfAnnoForCode('email').text),
          maxLines: 7,
          align: TextAlign.center,
        ),
        const SizedBox(height: P2),
        SmallText(loc.auth_register_troubleshooting_hint, align: TextAlign.center),
        MTButton(
          middle: SmallText(loc.contact_us_title.toLowerCase(), color: mainColor),
          onTap: () => sendMail(loc.contact_us_mail_subject, appTitle, accountController.user?.id),
        ),
        MTButton.main(
          margin: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P2),
          titleText: loc.ok,
          onTap: () => Navigator.of(context).pop(),
        ),
        const SizedBox(height: P2),
      ],
    );
  }
}
