// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color darkColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF333333),
  darkColor: Color(0xFFCCCCCC),
);

const Color darkGreyColor = CupertinoDynamicColor.withBrightness(
  color: Color(0xFF666666),
  darkColor: Color(0xFF888888),
);

const Color warningColor = CupertinoColors.activeOrange;
const Color dangerColor = CupertinoColors.destructiveRed;

const Color borderColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 200, 200, 205),
  darkColor: Color.fromARGB(255, 62, 62, 64),
);

const Color loaderColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(180, 200, 200, 205),
  darkColor: Color.fromARGB(180, 62, 62, 64),
);

const Color backgroundColor = CupertinoColors.systemGrey6;
const Color darkBackgroundColor = CupertinoColors.systemGrey5;

const Color _tealColor = Color.fromARGB(255, 90, 200, 250);
const Color _darkTealColor = Color.fromARGB(255, 0, 113, 164);

const Color mainColor = CupertinoDynamicColor.withBrightness(
  color: _darkTealColor,
  darkColor: _tealColor,
);

MaterialColor darkTealColorMaterial = MaterialColor(
  _darkTealColor.value,
  const <int, Color>{
    50: Color.fromARGB(255, 0, 174, 255),
    100: Color.fromARGB(255, 0, 166, 242),
    200: Color.fromARGB(255, 0, 157, 230),
    300: Color.fromARGB(255, 0, 139, 204),
    400: Color.fromARGB(255, 0, 122, 179),
    500: _darkTealColor,
    600: Color.fromARGB(255, 0, 105, 153),
    700: Color.fromARGB(255, 0, 87, 128),
    800: Color.fromARGB(255, 0, 70, 102),
    900: Color.fromARGB(255, 0, 52, 77),
  },
);

MaterialColor tealColorMaterial = MaterialColor(
  _tealColor.value,
  const <int, Color>{
    50: _tealColor,
    100: _tealColor,
    200: _tealColor,
    300: _tealColor,
    400: _tealColor,
    500: _tealColor,
    600: _tealColor,
    700: _tealColor,
    800: _tealColor,
    900: _tealColor,
  },
);

const Color goodPaceColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 120, 190, 142),
  darkColor: Color.fromARGB(255, 5, 80, 5),
);

const Color warningPaceColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 195, 65),
  darkColor: Color.fromARGB(255, 115, 70, 0),
);

// цвет для "прозрачного" апп-бара
// Color get appBarBgColor => const CupertinoDynamicColor.withBrightness(
//       color: Color.fromARGB(0, 255, 255, 255),
//       darkColor: Color.fromARGB(0, 0, 0, 0),
//     );

extension ResolvedColor on Color {
  Color resolve(BuildContext context) => CupertinoDynamicColor.resolve(this, context);
}
