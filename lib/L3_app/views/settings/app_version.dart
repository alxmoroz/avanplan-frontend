// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class AppVersion extends StatelessWidget {
  const AppVersion();
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      LightText(loc.app_title),
      const SizedBox(width: P / 4),
      NormalText(settingsController.appVersion),
    ]);
  }
}
