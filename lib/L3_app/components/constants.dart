// Copyright (c) 2022. Alexandr Moroz

import '../../L2_data/services/platform.dart';

const double P = 6;
const double P2 = P * 2; // 12
const double P3 = P * 3; // 18
const double P4 = P * 4; // 24
const double P5 = P * 5; // 30
const double P6 = P * 6; // 36
const double P7 = P * 7; // 42
const double P8 = P * 8; // 48
const double P10 = P * 10; // 60

const double P_2 = P / 2; // 3

const double DEF_BORDER_RADIUS = P2;
const double DEF_BTN_BORDER_RADIUS = P6;
const double DEF_BORDER_WIDTH = 2;
const double MIN_BTN_HEIGHT = P8;

const double SCR_XS_WIDTH = 360;
const double SCR_XS_HEIGHT = 480;

const double SCR_S_WIDTH = 480;
const double SCR_S_HEIGHT = 640;

const double SCR_M_WIDTH = 640;
const double SCR_M_HEIGHT = 860;

const double SCR_L_WIDTH = 860;

double get cardElevation => isWeb ? 5 : 1;
double get buttonElevation => isWeb ? 5 : 2;
