// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

const _bDC = 16;
const _b3r = 252;
const _b3g = _b3r;
const _b3b = _b3r;
const _b3 = Color.fromARGB(255, _b3r, _b3g, _b3b);
const _b2r = _b3r - _bDC;
const _b2g = _b3g - _bDC;
const _b2b = _b3b - _bDC;
const _b2 = Color.fromARGB(255, _b2r, _b2g, _b2b);
const _b1r = _b2r - _bDC;
const _b1g = _b2g - _bDC;
const _b1b = _b2b - _bDC;
const _b1 = Color.fromARGB(255, _b1r, _b1g, _b1b);

const _b1dr = 24;
const _b1dg = _b1dr;
const _b1db = _b1dr + 6;
const _b1Dark = Color.fromARGB(255, _b1dr, _b1dg, _b1db);
const _b2dr = _b1dr + _bDC;
const _b2dg = _b1dg + _bDC;
const _b2db = _b1db + _bDC;
const _b2Dark = Color.fromARGB(255, _b2dr, _b2dg, _b2db);
const _b3dr = _b2dr + _bDC;
const _b3dg = _b2dg + _bDC;
const _b3db = _b2db + _bDC;
const _b3Dark = Color.fromARGB(255, _b3dr, _b3dg, _b3db);

const _fDC = 70;
const _f3r = _b1r - _bDC;
const _f3g = _f3r;
const _f3b = _f3r + 6;
const _f3 = Color.fromARGB(255, _f3r, _f3g, _f3b);
const _f2r = _f3r - _fDC;
const _f2g = _f3g - _fDC;
const _f2b = _f3b - _fDC;
const _f2 = Color.fromARGB(255, _f2r, _f2g, _f2b);
const _f1r = _f2r - _fDC;
const _f1g = _f2g - _fDC;
const _f1b = _f2b - _fDC;
const _f1 = Color.fromARGB(255, _f1r, _f1g, _f1b);

const _f3dr = _b3dr + _bDC;
const _f3dg = _f3dr;
const _f3db = _f3dr;
const _f3Dark = Color.fromARGB(255, _f3dr, _f3dg, _f3db);
const _f2dr = _f3dr + _fDC;
const _f2dg = _f3dg + _fDC;
const _f2db = _f3db + _fDC;
const _f2Dark = Color.fromARGB(255, _f2dr, _f2dg, _f2db);
const _f1dr = _f2dr + _fDC;
const _f1dg = _f2dg + _fDC;
const _f1db = _f2db + _fDC;
const _f1Dark = Color.fromARGB(255, _f1dr, _f1dg, _f1db);

// L1
const b1Color = CupertinoDynamicColor.withBrightness(color: _b1, darkColor: _b1Dark);
const f1Color = CupertinoDynamicColor.withBrightness(color: _f1, darkColor: _f1Dark);
// L2
const b2Color = CupertinoDynamicColor.withBrightness(color: _b2, darkColor: _b2Dark);
const f2Color = CupertinoDynamicColor.withBrightness(color: _f2, darkColor: _f2Dark);
// L3
const b3Color = CupertinoDynamicColor.withBrightness(color: _b3, darkColor: _b3Dark);
const f3Color = CupertinoDynamicColor.withBrightness(color: _f3, darkColor: _f3Dark);

const mainBtnTitleColor = CupertinoDynamicColor.withBrightness(color: _b3, darkColor: _f1Dark);
const btnShadowColor = CupertinoDynamicColor.withBrightness(
  color: Color.fromARGB(255, 255, 255, 255),
  darkColor: Color.fromARGB(255, 0, 0, 0),
);
