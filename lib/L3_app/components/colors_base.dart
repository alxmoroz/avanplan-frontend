// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

/// Цвета фона

// контраст между цветами фона
const _bDC = 18;

/// светлая тема
const _b3r = 254;
const _b3g = 253;
const _b3b = 252;

const _b2r = _b3r - _bDC;
const _b2g = _b3g - _bDC;
const _b2b = _b3b - _bDC;

const _b1r = _b2r - _bDC;
const _b1g = _b2g - _bDC;
const _b1b = _b2b - _bDC;

/// темная тема
const _b1dr = 26;
const _b1dg = 26;
const _b1db = 26 + 8;

const _b2dr = _b1dr + _bDC;
const _b2dg = _b1dg + _bDC;
const _b2db = _b1db + _bDC;

const _b3dr = _b2dr + _bDC;
const _b3dg = _b2dg + _bDC;
const _b3db = _b2db + _bDC;

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

/// второстепенный фон (нижний уровень)
const b1Color = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, _b1r, _b1g, _b1b),
  darkColor: Color.fromARGB(255, _b1dr, _b1dg, _b1db),
);

/// Цвета текста и элементов

// контраст между соседними цветами текста и элементов
const _fDC = 58;

// контраст между фоном и незаметным цветом
const _delta_fg_bg = 34;

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
