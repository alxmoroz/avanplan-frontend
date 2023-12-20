// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

/// Цвета фона

/// светлая тема
const _b3R = 255;
const _b3G = 254;
const _b3B = 253;

const _b2R = 240;
const _b2G = 242;
const _b2B = 250;

const _b1R = 202;
const _b1G = 210;
const _b1B = 244;

const _b0R = 110;
const _b0G = 120;
const _b0B = 150;

/// темная тема
const _b3R_d = 48;
const _b3G_d = 52;
const _b3B_d = 74;

const _b2R_d = 36;
const _b2G_d = 42;
const _b2B_d = 66;

const _b1R_d = 18;
const _b1G_d = 22;
const _b1B_d = 48;

const _b0R_d = 6;
const _b0G_d = 12;
const _b0B_d = 32;

/// самый яркий фон (выпирающий цвет)
const b3Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b3R, _b3G, _b3B),
  darkColor: Color.fromARGB(255, _b3R_d, _b3G_d, _b3B_d),
);

/// основной фон
const b2Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b2R, _b2G, _b2B),
  darkColor: Color.fromARGB(255, _b2R_d, _b2G_d, _b2B_d),
);

/// второстепенный фон (нижний уровень)
const b1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b1R, _b1G, _b1B),
  darkColor: Color.fromARGB(255, _b1R_d, _b1G_d, _b1B_d),
);

/// тень фона
const b0Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b0R, _b0G, _b0B),
  darkColor: Color.fromARGB(255, _b0R_d, _b0G_d, _b0B_d),
);

/// Цвета текста и элементов

// контраст между соседними цветами текста или элементами
const _fDC = 58;

/// светлая тема
const _f3R = _b1R - 20;
const _f3G = _b1G - 20;
const _f3B = _b1R - 4;

const _f2R = _f3R - _fDC;
const _f2G = _f3G - _fDC;
const _f2B = _f3B - _fDC;

const _f1R = _f2R - _fDC;
const _f1G = _f2G - _fDC;
const _f1B = _f2B - _fDC;

/// темная тема
const _f3R_d = _b3R_d + 38;
const _f3G_d = _b3G_d + 38;
const _f3B_d = _b3B_d + 26;

const _f2R_d = _f3R_d + _fDC;
const _f2G_d = _f3G_d + _fDC;
const _f2B_d = _f3B_d + _fDC;

const _f1R_d = _f2R_d + _fDC;
const _f1G_d = _f2G_d + _fDC;
const _f1B_d = _f2B_d + _fDC;

/// основной цвет
const f1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _f1R, _f1G, _f1B),
  darkColor: Color.fromARGB(255, _f1R_d, _f1G_d, _f1B_d),
);

/// дополнительный цвет
const f2Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _f2R, _f2G, _f2B),
  darkColor: Color.fromARGB(255, _f2R_d, _f2G_d, _f2B_d),
);

/// незаметный цвет
const f3Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _f3R, _f3G, _f3B),
  darkColor: Color.fromARGB(255, _f3R_d, _f3G_d, _f3B_d),
);
