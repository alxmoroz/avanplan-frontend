// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L2_data/services/environment.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
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
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          LightText(localSettingsController.settings.version, color: f2Color),
          if (visibleApiHost.isNotEmpty) NormalText(visibleApiHost, color: warningColor, padding: const EdgeInsets.only(left: P_2)),
        ]),
      ],
    );
  }
}
