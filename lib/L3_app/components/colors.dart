// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import 'colors_base.dart';

const mainColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 90, 111, 228),
  darkColor: Color.fromARGB(255, 100, 170, 255),
);

const greenColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 31, 188, 180),
  darkColor: Color.fromARGB(255, 44, 197, 189),
);

const greenLightColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(42, 31, 188, 180),
  darkColor: Color.fromARGB(42, 44, 197, 189),
);

const dangerColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 140, 80),
  darkColor: Color.fromARGB(255, 255, 142, 90),
);

const warningColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 192, 8),
  darkColor: Color.fromARGB(255, 255, 200, 20),
);

// цвет текста на основной кнопке
const mainBtnTitleColor = b2Color;

// цвет для "прозрачного" апп-бара
const navbarColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(0, 255, 255, 255),
  darkColor: Color.fromARGB(0, 0, 0, 0),
);

extension ResolvedColor on Color {
  Color resolve(BuildContext context) => CupertinoDynamicColor.resolve(this, context);
}
