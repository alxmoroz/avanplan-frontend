// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/images.dart';
import '../../components/text.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../usecases/communications.dart';
import 'registration_request_controller.dart';

class RegistrationCompletedMessage extends StatelessWidget {
  const RegistrationCompletedMessage(this._controller, {super.key});

  final RegistrationRequestController _controller;

  String get _email => _controller.fData(RegistrationFCode.email.index).text;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        MTImage(ImageName.notifications.name),
        H2(
          loc.register_completed_hint,
          align: TextAlign.center,
          padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P3),
        ),
        BaseText(
          loc.register_completed_description,
          align: TextAlign.center,
          padding: const EdgeInsets.symmetric(horizontal: P2),
        ),
        BaseText.f2(
          _email,
          align: TextAlign.center,
          maxLines: 1,
          padding: const EdgeInsets.symmetric(horizontal: P),
        ),
        MTButton.main(
          margin: const EdgeInsets.symmetric(vertical: P3),
          titleText: loc.ok,
          onTap: router.pop,
        ),
        const SizedBox(height: P6),
        SmallText(loc.register_troubleshooting_hint, align: TextAlign.center),
        MTButton(
          middle: SmallText(loc.contact_us_title.toLowerCase(), color: mainColor),
          onTap: mailUs,
        ),
        if (MediaQuery.paddingOf(context).bottom == 0) const SizedBox(height: P3),
      ],
    );
  }
}
