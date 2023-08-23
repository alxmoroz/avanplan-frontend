// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

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
