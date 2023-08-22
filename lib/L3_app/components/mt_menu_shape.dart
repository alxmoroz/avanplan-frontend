// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'mt_card.dart';
import 'text_widgets.dart';

// TODO: используется только в одном месте: добавление участника в проект

class MTMenuShape extends StatelessWidget {
  const MTMenuShape({this.icon, this.title}) : assert(icon != null || title != null);

  final Widget? icon;
  final String? title;

  @override
  Widget build(BuildContext context) => MTCard(
        radius: DEF_BTN_BORDER_RADIUS,
        shadowColor: mainColor,
        color: mainColor,
        elevation: 2,
        padding: const EdgeInsets.all(P),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            if (title != null) MediumText(title!, color: mainBtnTitleColor, padding: const EdgeInsets.symmetric(horizontal: P_2)),
          ],
        ),
      );
}
