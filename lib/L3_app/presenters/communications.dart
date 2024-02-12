// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../components/button.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../extra/services.dart';
import '../usecases/communications.dart';

String get appTitle => '${loc.app_title} ${localSettingsController.settings.version}';

class ReportErrorButton extends StatelessWidget {
  const ReportErrorButton(this.errorText, {super.key, this.color, this.titleColor = mainColor});
  final String errorText;
  final Color? color;
  final Color titleColor;

  @override
  Widget build(BuildContext context) {
    return MTButton.secondary(
      leading: MailIcon(color: titleColor, size: P4),
      titleText: loc.report_bug_action_title,
      titleColor: titleColor,
      color: color,
      margin: const EdgeInsets.only(top: P3),
      onTap: () => mailUs(text: errorText),
    );
  }
}
