// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/colors_base.dart';
import '../../../components/images.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';

class AppTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        MTImage(ImageName.app_icon.name, height: 30, width: 30),
        DecorAppTitle(loc.app_title.substring(1), color: f2Color, padding: const EdgeInsets.only(top: 15, left: 2)),
      ],
    );
  }
}
