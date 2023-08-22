// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

const bgL1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 230, 230, 232),
  darkColor: Color.fromARGB(255, 18, 18, 22),
);

const fgL1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 220, 220, 224),
  darkColor: Color.fromARGB(255, 68, 68, 72),
);

const bgL2Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 239, 239, 239),
  darkColor: Color.fromARGB(255, 26, 26, 30),
);

const fgL2Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 182, 182, 192),
  darkColor: Color.fromARGB(255, 100, 100, 110),
);

const bgL3Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 253, 253, 253),
  darkColor: Color.fromARGB(255, 42, 42, 46),
);

const fgL3Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 52, 52, 60),
  darkColor: Color.fromARGB(255, 210, 210, 212),
);

const dangerColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 120, 75),
  darkColor: Color.fromARGB(255, 255, 140, 100),
);

const goldColor = CupertinoColors.systemYellow;

const warningColor = CupertinoColors.activeOrange;

const warningDarkColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 210, 130),
  darkColor: Color.fromARGB(255, 140, 90, 35),
);

const warningLightColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 242, 190),
  darkColor: Color.fromARGB(255, 115, 65, 10),
);

const greenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 42, 182, 150),
  darkColor: Color.fromARGB(255, 52, 202, 185),
);

const mainColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 52, 150, 225),
  darkColor: Color.fromARGB(255, 80, 170, 255),
);

// цвет для "прозрачного" апп-бара
const transparentAppbarBgColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(0, 255, 255, 255),
  darkColor: Color.fromARGB(0, 0, 0, 0),
);

Color get navbarDefaultBgColor => transparentAppbarBgColor;

extension ResolvedColor on Color {
  Color resolve(BuildContext context) => CupertinoDynamicColor.resolve(this, context);
  Color? maybeResolve(BuildContext context) => CupertinoDynamicColor.maybeResolve(this, context);
}
