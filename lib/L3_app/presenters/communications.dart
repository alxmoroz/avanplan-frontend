// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L2_data/repositories/communications_repo.dart';
import '../../L3_app/extra/services.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/mt_button.dart';

String get appTitle => '${loc.app_title} ${localSettingsController.settings.version}';

class ReportErrorButton extends StatelessWidget {
  const ReportErrorButton(this.errorText, {this.color, this.titleColor});
  final String errorText;
  final Color? color;
  final Color? titleColor;

  @override
  Widget build(BuildContext context) {
    return MTButton.secondary(
      leading: MailIcon(color: titleColor),
      titleText: loc.report_bug_action_title,
      titleColor: titleColor,
      color: color,
      margin: const EdgeInsets.only(top: P),
      onTap: () => sendMail(loc.contact_us_mail_subject, appTitle, accountController.user?.id, errorText),
    );
  }
}
