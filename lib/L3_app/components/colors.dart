// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

const Color darkGreyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 52, 52, 56),
  darkColor: Color.fromARGB(255, 204, 204, 208),
);

const Color greyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 82, 82, 90),
  darkColor: Color.fromARGB(255, 152, 152, 164),
);

const Color lightGreyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 178, 178, 196),
  darkColor: Color.fromARGB(255, 80, 80, 84),
);

const Color borderColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 220, 220, 224),
  darkColor: Color.fromARGB(255, 70, 70, 72),
);

const Color darkBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 231, 231, 233),
  darkColor: Color.fromARGB(255, 42, 42, 45),
);

const backgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 242, 242, 244),
  darkColor: Color.fromARGB(255, 28, 28, 32),
);

const Color lightBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 253, 253, 255),
  darkColor: Color.fromARGB(255, 8, 8, 12),
);

const Color dangerColor = CupertinoColors.destructiveRed;

const Color goldColor = CupertinoColors.systemYellow;

const Color warningColor = CupertinoColors.activeOrange;
const Color lightWarningColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(60, 255, 202, 120),
  darkColor: Color.fromARGB(60, 115, 70, 0),
);

const Color greenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 64, 170, 94),
  darkColor: Color.fromARGB(255, 52, 165, 89),
);

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

extension ResolvedColor on Color {
  Color resolve(BuildContext context) => CupertinoDynamicColor.resolve(this, context);
  Color? maybeResolve(BuildContext context) => CupertinoDynamicColor.maybeResolve(this, context);
}
