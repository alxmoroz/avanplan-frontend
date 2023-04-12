// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_card.dart';
import 'text_widgets.dart';

class MTMenuShape extends StatelessWidget {
  const MTMenuShape({this.icon, this.title}) : assert(icon != null || title != null);

  final Widget? icon;
  final String? title;

  @override
  Widget build(BuildContext context) => MTCard(
        // width: MIN_BTN_HEIGHT,
        // height: MIN_BTN_HEIGHT,
        // decoration: BoxDecoration(
        //   borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS),
        //   border: Border.fromBorderSide(BorderSide(color: mainColor.resolve(context), width: DEF_BORDER_WIDTH)),
        // ),
        borderSide: BorderSide(color: mainColor.resolve(context), width: 1),
        shadowColor: mainColor,
        elevation: 2,
        padding: const EdgeInsets.all(P),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (title != null) MediumText(title!, color: mainColor, padding: const EdgeInsets.symmetric(horizontal: P_2)),
          ],
        ),
      );
}
