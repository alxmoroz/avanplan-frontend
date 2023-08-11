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
  darkColor: Color.fromARGB(255, 68, 68, 72),
);

const Color darkBackgroundColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 231, 231, 233),
  darkColor: Color.fromARGB(255, 48, 48, 52),
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
  color: Color.fromARGB(255, 255, 120, 75),
  darkColor: Color.fromARGB(255, 255, 140, 100),
);

const Color goldColor = CupertinoColors.systemYellow;

const Color warningColor = CupertinoColors.activeOrange;

const Color warningDarkColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 210, 130),
  darkColor: Color.fromARGB(255, 140, 90, 35),
);

const Color warningLightColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 242, 190),
  darkColor: Color.fromARGB(255, 115, 65, 10),
);

const Color greenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 42, 182, 150),
  darkColor: Color.fromARGB(255, 52, 202, 185),
);

const Color mainColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 52, 150, 225),
  darkColor: Color.fromARGB(255, 80, 170, 255),
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
