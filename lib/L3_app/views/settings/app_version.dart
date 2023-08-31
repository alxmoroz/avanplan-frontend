// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L2_data/services/environment.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text.dart';
import '../../extra/services.dart';

class AppVersion extends StatelessWidget {
  const AppVersion();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          BaseText.f3(localSettingsController.settings.version),
          if (visibleApiHost.isNotEmpty) BaseText.medium(visibleApiHost, color: dangerColor, padding: const EdgeInsets.only(left: P2)),
        ]),
      ],
    );
  }
}
