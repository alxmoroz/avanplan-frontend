// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

const Color darkGreyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 62, 62, 82),
  darkColor: Color.fromARGB(255, 204, 204, 204),
);

const Color greyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 86, 86, 120),
  darkColor: Color.fromARGB(255, 150, 150, 159),
);

const Color lightGreyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 180, 180, 190),
  darkColor: Color.fromARGB(255, 76, 76, 84),
);

const Color borderColor = CupertinoColors.systemGrey3;

const Color darkBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 231, 231, 233),
  darkColor: Color.fromARGB(255, 45, 42, 42),
);

const backgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 252, 251, 251),
  darkColor: Color.fromARGB(255, 32, 28, 27),
);

const Color lightBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 250, 252, 255),
  darkColor: Color.fromARGB(255, 10, 10, 15),
);

const Color dangerColor = CupertinoColors.destructiveRed;

const Color warningColor = CupertinoColors.activeOrange;
const Color lightWarningColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(60, 255, 202, 120),
  darkColor: Color.fromARGB(60, 115, 70, 0),
);

const Color greenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 64, 170, 94),
  darkColor: Color.fromARGB(255, 52, 165, 89),
);

// const Color lightGreenColor = CupertinoDynamicColor.withBrightness(
//   color: Color.fromARGB(100, 28, 120, 52),
//   darkColor: Color.fromARGB(100, 52, 165, 89),
// );

const Color mainColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 30, 150, 220),
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
