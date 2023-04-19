// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L2_data/services/environment.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class AppVersion extends StatelessWidget {
  const AppVersion();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: P_2),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          SmallText(localSettingsController.settings.version, color: lightGreyColor),
          if (visibleApiHost.isNotEmpty) SmallText(visibleApiHost, color: warningColor, padding: const EdgeInsets.only(left: P_2)),
        ]),
      ],
    );
  }
}
