// Copyright (c) 2021. Alexandr Moroz

import 'package:flutter/cupertino.dart';

Color _r(CupertinoDynamicColor color, BuildContext ctx) => CupertinoDynamicColor.resolve(color, ctx);

Color get darkColor => const CupertinoDynamicColor.withBrightness(color: Color(0xFF333333), darkColor: Color(0xFFCCCCCC));

Color get darkGreyColor => const CupertinoDynamicColor.withBrightness(color: Color(0xFF666666), darkColor: Color(0xFF888888));

Color get warningColor => CupertinoColors.activeOrange;

Color get borderColor => const CupertinoDynamicColor.withBrightness(
      color: Color.fromARGB(255, 209, 209, 214),
      darkColor: Color.fromARGB(255, 58, 58, 60),
    );

Color greyColor5(BuildContext ctx) => _r(CupertinoColors.systemGrey5, ctx);

Color greyColor6(BuildContext ctx) => _r(CupertinoColors.systemGrey6, ctx);

Color secondaryBackgroundColor(BuildContext ctx) => _r(CupertinoColors.secondarySystemBackground, ctx);
