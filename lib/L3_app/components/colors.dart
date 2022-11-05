// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

// TODO: разобраться с серым цветом. По факту используется в коде не учитывая названия

const Color darkColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF424242),
  darkColor: Color(0xFFCCCCCC),
);

const Color darkGreyColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF666666),
  darkColor: Color(0xFF999999),
);

const Color lightGreyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 180, 180, 190),
  darkColor: Color.fromARGB(255, 72, 72, 74),
);

const Color borderColor = CupertinoColors.systemGrey3;
const Color darkBackgroundColor = CupertinoColors.systemGrey5;
const Color backgroundColor = CupertinoColors.systemGrey6;

const Color dangerColor = CupertinoColors.destructiveRed;

const Color warningColor = CupertinoColors.activeOrange;
const Color lightWarningColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(60, 255, 202, 120),
  darkColor: Color.fromARGB(60, 115, 70, 0),
);

const Color greenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 28, 120, 52),
  darkColor: Color.fromARGB(255, 52, 165, 89),
);

// const Color lightGreenColor = CupertinoDynamicColor.withBrightness(
//   color: Color.fromARGB(100, 28, 120, 52),
//   darkColor: Color.fromARGB(100, 52, 165, 89),
// );

const Color mainColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 0, 113, 164),
  darkColor: Color.fromARGB(255, 90, 200, 250),
);

// цвет для "прозрачного" апп-бара
const Color transparentAppbarBgColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(0, 255, 255, 255),
  darkColor: Color.fromARGB(0, 0, 0, 0),
);

Color get navbarDefaultBgColor => transparentAppbarBgColor;

const Color googleBtnColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFFFFFFFF),
  darkColor: Color(0xFF4285F4),
);

extension ResolvedColor on Color {
  Color resolve(BuildContext context) => CupertinoDynamicColor.resolve(this, context);
  Color? maybeResolve(BuildContext context) => CupertinoDynamicColor.maybeResolve(this, context);
}
