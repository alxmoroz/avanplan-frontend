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
const double P9 = P * 9; // 54
const double P10 = P * 10; // 60
const double P11 = P * 11; // 66
const double P12 = P * 12; // 72

const double P_2 = P / 2; // 3
const double P_3 = P / 3; // 2

const double DEF_PAGE_TOP_PADDING = P3;
const double DEF_PAGE_BOTTOM_PADDING = P5;
const double DEF_DIALOG_BOTTOM_PADDING = P3;
const double DEF_BORDER_RADIUS = P2;
const double DEF_BTN_BORDER_RADIUS = MIN_BTN_HEIGHT / 2;
const double DEF_BORDER_WIDTH = P_3;
const double MIN_BTN_HEIGHT = P8;

const double SCR_XXS_WIDTH = 290;
const double SCR_XS_WIDTH = 364;
const double SCR_XS_HEIGHT = 480;

const double SCR_S_WIDTH = 480;
const double SCR_S_HEIGHT = 640;

const double SCR_M_WIDTH = 640;
const double SCR_M_HEIGHT = 860;

const double SCR_L_WIDTH = 760;
const double SCR_XL_WIDTH = 960;
const double SCR_XXL_WIDTH = 1280;

const TEXT_SAVE_DELAY_DURATION = Duration(milliseconds: 500);
const KB_RELATED_ANIMATION_DURATION = Duration(milliseconds: 200);

double get cardElevation => isWeb ? 3 : 1;
double get buttonElevation => isWeb ? 3 : 1;
