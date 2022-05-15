// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/colors.dart';
import '../../components/icons.dart';

Color? stateColor(OverallState state) => {
      OverallState.overdue: dangerColor,
      OverallState.risk: riskyColor,
      OverallState.ok: okColor,
    }[state];

Color? stateBgColor(OverallState state) => {
      OverallState.overdue: bgRiskyColor,
      OverallState.risk: bgRiskyColor,
      OverallState.ok: bgOkColor,
    }[state];

Widget stateIcon(BuildContext context, OverallState state, [double? size]) =>
    {
      OverallState.overdue: overdueIcon(context, size: size),
      OverallState.risk: badPaceIcon(context, size: size),
      OverallState.ok: goodPaceIcon(context, size: size),
    }[state] ??
    noInfoIcon(context, size: size);
