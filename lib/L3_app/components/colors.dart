// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

const bgL1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 230, 230, 232),
  darkColor: Color.fromARGB(255, 18, 18, 22),
);
const fgL1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 189, 189, 192),
  darkColor: Color.fromARGB(255, 82, 82, 86),
);

const bgL2Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 239, 239, 239),
  darkColor: Color.fromARGB(255, 26, 26, 30),
);
const fgL2Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 142, 142, 146),
  darkColor: Color.fromARGB(255, 153, 153, 157),
);

const _whiteLightColor = Color.fromARGB(255, 253, 253, 253);
const _whiteDarkColor = Color.fromARGB(255, 235, 235, 239);

const mainBtnTitleColor = CupertinoDynamicColor.withBrightness(
  color: _whiteLightColor,
  darkColor: _whiteDarkColor,
);

const bgL3Color = CupertinoDynamicColor.withBrightness(
  color: _whiteLightColor,
  darkColor: Color.fromARGB(255, 42, 42, 46),
);
const fgL3Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 55, 55, 60),
  darkColor: _whiteDarkColor,
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
  color: Color.fromARGB(255, 90, 111, 228),
  darkColor: Color.fromARGB(255, 90, 111, 228),
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
