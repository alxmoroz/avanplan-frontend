// Copyright (c) 2022. Alexandr Moroz

import '../../L2_data/services/platform.dart';

const double P = 12;
const double P2 = P * 2;
const double P3 = P * 3;
const double P_2 = P / 2;
const double P_3 = P / 3;
const double P_6 = P / 6;

const double DEF_BORDER_RADIUS = P * 1;
const double DEF_BTN_BORDER_RADIUS = P3;
const double DEF_BORDER_WIDTH = 2;
const double MIN_BTN_HEIGHT = P * 4;

const double SCR_S_HEIGHT = 480;
const double SCR_M_HEIGHT = 540;
const double SCR_L_HEIGHT = 920;

const double SCR_S_WIDTH = 360;
const double SCR_M_WIDTH = 700;
const double SCR_L_WIDTH = 860;

double? get cardElevation => isWeb ? 5 : null;
