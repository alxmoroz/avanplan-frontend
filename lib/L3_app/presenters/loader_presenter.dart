// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/text_widgets.dart';

double get ldrIconSize => P * 20;

const Color ldrIconColor = darkBackgroundColor;

Widget get ldrDefaultIcon => appIcon();
Widget get ldrAuthIcon => PrivacyIcon(size: ldrIconSize, color: ldrIconColor);
Widget get ldrNetworkErrorIcon => NetworkErrorIcon(size: ldrIconSize, color: ldrIconColor);
Widget get ldrServerErrorIcon => ServerErrorIcon(size: ldrIconSize, color: ldrIconColor);
Widget get ldrRefreshIcon => RefreshIcon(size: ldrIconSize, color: ldrIconColor);
Widget get ldrImportIcon => ImportIcon(size: ldrIconSize, color: ldrIconColor);
Widget get ldrPurchaseIcon => PurchaseIcon(size: ldrIconSize, color: ldrIconColor);

Widget ldrTitle(String titleText) => H3(
      titleText,
      align: TextAlign.center,
      padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P),
    );

Widget ldrDescription(String descriptionText) => H4(
      descriptionText,
      align: TextAlign.center,
      padding: const EdgeInsets.symmetric(horizontal: P).copyWith(top: P_2),
      maxLines: 5,
    );
