// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

/// Цвета фона

/// светлая тема
const _b3r = 255;
const _b3g = 254;
const _b3b = 253;

const _b2r = 244;
const _b2g = 245;
const _b2b = 247;

const _b2rTint = 218;
const _b2gTint = 219;
const _b2bTint = 253;

const _b1r = 228;
const _b1g = 230;
const _b1b = 234;

/// темная тема
const _b3dr = 50;
const _b3dg = 52;
const _b3db = 66;

const _b2dr = 44;
const _b2dg = 46;
const _b2db = 60;

const _b2drTint = 28;
const _b2dgTint = 30;
const _b2dbTint = 44;

const _b1dr = 38;
const _b1dg = 40;
const _b1db = 48;

/// самый яркий фон (выпирающий цвет)
const b3Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b3r, _b3g, _b3b),
  darkColor: Color.fromARGB(255, _b3dr, _b3dg, _b3db),
);

/// основной фон
const b2Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b2r, _b2g, _b2b),
  darkColor: Color.fromARGB(255, _b2dr, _b2dg, _b2db),
);

const b2TintColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b2rTint, _b2gTint, _b2bTint),
  darkColor: Color.fromARGB(255, _b2drTint, _b2dgTint, _b2dbTint),
);

/// второстепенный фон (нижний уровень)
const b1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b1r, _b1g, _b1b),
  darkColor: Color.fromARGB(255, _b1dr, _b1dg, _b1db),
);

/// Цвета текста и элементов

// контраст между соседними цветами текста или элементами
const _fDC = 58;

// контраст между фоном и незаметным цветом
const _delta_fg_bg = 32;

/// светлая тема
const _f3r = _b1r - _delta_fg_bg;
const _f3g = _f3r;
const _f3b = _f3r + 8;

const _f2r = _f3r - _fDC;
const _f2g = _f3g - _fDC;
const _f2b = _f3b - _fDC;

const _f1r = _f2r - _fDC;
const _f1g = _f2g - _fDC;
const _f1b = _f2b - _fDC;

/// темная тема
const _f3dr = _b3dr + _delta_fg_bg;
const _f3dg = _f3dr;
const _f3db = _f3dr;

const _f2dr = _f3dr + _fDC;
const _f2dg = _f3dg + _fDC;
const _f2db = _f3db + _fDC;

const _f1dr = _f2dr + _fDC;
const _f1dg = _f2dg + _fDC;
const _f1db = _f2db + _fDC;

/// основной цвет
const f1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _f1r, _f1g, _f1b),
  darkColor: Color.fromARGB(255, _f1dr, _f1dg, _f1db),
);

/// дополнительный цвет
const f2Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _f2r, _f2g, _f2b),
  darkColor: Color.fromARGB(255, _f2dr, _f2dg, _f2db),
);

/// незаметный цвет
const f3Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _f3r, _f3g, _f3b),
  darkColor: Color.fromARGB(255, _f3dr, _f3dg, _f3db),
);
