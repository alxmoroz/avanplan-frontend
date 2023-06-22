// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

const Color darkTextColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 52, 52, 60),
  darkColor: Color.fromARGB(255, 210, 210, 212),
);

const Color greyTextColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 90, 90, 98),
  darkColor: Color.fromARGB(255, 172, 172, 178),
);

const Color greyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 142, 142, 152),
  darkColor: Color.fromARGB(255, 142, 142, 152),
);

const Color lightGreyColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 182, 182, 190),
  darkColor: Color.fromARGB(255, 100, 100, 110),
);

const Color borderColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 220, 220, 224),
  darkColor: Color.fromARGB(255, 70, 70, 72),
);

const Color darkBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 231, 231, 233),
  darkColor: Color.fromARGB(255, 52, 52, 60),
);

const backgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 242, 242, 244),
  darkColor: Color.fromARGB(255, 28, 28, 32),
);

const Color lightBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 253, 253, 255),
  darkColor: Color.fromARGB(255, 8, 8, 12),
);

const Color dangerColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 120, 95),
  darkColor: Color.fromARGB(255, 255, 140, 100),
);

const Color goldColor = CupertinoColors.systemYellow;

const Color warningColor = CupertinoColors.activeOrange;

const Color greenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 42, 184, 168),
  darkColor: Color.fromARGB(255, 52, 204, 195),
);

const Color mainColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 56, 130, 220),
  darkColor: Color.fromARGB(255, 90, 180, 255),
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
