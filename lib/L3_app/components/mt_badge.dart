// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors.dart';
import 'constants.dart';
import 'text_widgets.dart';

class MTBadge extends StatelessWidget {
  const MTBadge(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    final dir = CupertinoTheme.brightnessOf(context) == Brightness.dark ? 1 : -1;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: onePadding / 1.75, vertical: onePadding / 6),
      decoration: BoxDecoration(
        color: darkBackgroundColor.resolve(context),
        borderRadius: BorderRadius.circular(onePadding),
        boxShadow: [
          BoxShadow(color: darkGreyColor.resolve(context), offset: Offset(0, dir * 0.4)),
          BoxShadow(color: CupertinoColors.systemBackground.resolve(context), offset: Offset(0, dir * -0.4)),
        ],
      ),
      child: SmallText(text, color: darkGreyColor),
    );
  }
}
