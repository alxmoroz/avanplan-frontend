// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/colors.dart';
import '../../components/icons.dart';
import '../../extra/services.dart';

const _colors = {
  OverallState.overdue: dangerColor,
  OverallState.risk: riskyColor,
  OverallState.ok: okColor,
};

const _bgColors = {
  OverallState.overdue: bgRiskyColor,
  OverallState.risk: bgRiskyColor,
  OverallState.ok: bgOkColor,
};

Color? stateColor(OverallState state) => _colors[state];
Color? stateBgColor(OverallState state) => _bgColors[state];

Widget stateIcon(BuildContext context, OverallState state, [double? size]) {
  Widget icon = noInfoStateIcon(context, size: size);
  switch (state) {
    case OverallState.overdue:
      icon = overdueStateIcon(context, size: size);
      break;
    case OverallState.risk:
      icon = riskStateIcon(context, size: size);
      break;
    case OverallState.ok:
      icon = okStateIcon(context, size: size);
      break;
    case OverallState.noInfo:
  }
  return icon;
}

String stateTextTitle(OverallState state) {
  String res = loc.smart_state_no_info_title;
  switch (state) {
    case OverallState.overdue:
      res = loc.smart_state_overdue_title;
      break;
    case OverallState.risk:
      res = loc.smart_state_risky_title;
      break;
    case OverallState.ok:
      res = loc.smart_state_ok_title;
      break;
    case OverallState.noInfo:
  }
  return res;
}

String stateTextDetails(OverallState state, {Duration? overduePeriod, Duration? etaRiskPeriod}) {
  String res = '';
  switch (state) {
    case OverallState.overdue:
      res = '${loc.smart_state_overdue_details} ${loc.common_days_count(overduePeriod!.inDays)}';
      break;
    case OverallState.risk:
      res = '${loc.smart_state_risky_details} ${loc.common_days_count(etaRiskPeriod!.inDays)}';
      break;
    case OverallState.ok:
    case OverallState.noInfo:
  }
  return res;
}
