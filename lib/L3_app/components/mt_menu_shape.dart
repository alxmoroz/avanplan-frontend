// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'text_widgets.dart';

class MTMenuShape extends StatelessWidget {
  const MTMenuShape({this.icon, this.title}) : assert(icon != null || title != null);

  final Widget? icon;
  final String? title;

  @override
  Widget build(BuildContext context) => Container(
        width: MIN_BTN_HEIGHT,
        height: MIN_BTN_HEIGHT,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS),
          border: Border.fromBorderSide(BorderSide(color: mainColor.resolve(context), width: DEF_BORDER_WIDTH)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (title != null) MediumText(title!, color: mainColor, padding: const EdgeInsets.symmetric(horizontal: P_2)),
          ],
        ),
      );
}
