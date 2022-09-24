// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

const Color borderColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 200, 200, 205),
  darkColor: Color.fromARGB(255, 62, 62, 64),
);

const Color loaderColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(180, 200, 200, 205),
  darkColor: Color.fromARGB(180, 62, 62, 64),
);

const Color darkBackgroundColor = CupertinoColors.systemGrey5;
const Color backgroundColor = CupertinoColors.systemGrey6;

const Color dangerColor = CupertinoColors.destructiveRed;

const Color warningColor = CupertinoColors.activeOrange;
const Color lightWarningColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 195, 65),
  darkColor: Color.fromARGB(255, 115, 70, 0),
);

const Color greenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 120, 190, 142),
  darkColor: Color.fromARGB(255, 5, 80, 5),
);

const Color bgGreenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(120, 120, 190, 142),
  darkColor: Color.fromARGB(120, 5, 80, 5),
);

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

// цвет для "прозрачного" апп-бара
const Color transparentAppbarBgColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(0, 255, 255, 255),
  darkColor: Color.fromARGB(0, 0, 0, 0),
);

Color get inactiveColor => const CupertinoDynamicColor.withBrightness(
      color: Color(0xFF758599),
      darkColor: Color(0xFF999999),
    );

Color get navbarBgColor => const CupertinoDynamicColor.withBrightness(
      color: Color.fromARGB(150, 209, 209, 214),
      darkColor: Color.fromARGB(150, 58, 58, 60),
    );

extension ResolvedColor on Color {
  Color resolve(BuildContext context) => CupertinoDynamicColor.resolve(this, context);
}
