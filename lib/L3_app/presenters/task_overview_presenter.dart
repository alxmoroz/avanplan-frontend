// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_ext_state.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../extra/services.dart';

const _colors = {
  TaskState.overdue: dangerColor,
  TaskState.risk: riskyColor,
  TaskState.ok: okColor,
};

const _bgColors = {
  TaskState.overdue: bgRiskyColor,
  TaskState.risk: bgRiskyColor,
  TaskState.ok: bgOkColor,
};

extension TaskStatePresenter on Task {
  Color? get stateColor => _colors[state];

  Color? get stateBgColor => _bgColors[state];

  Widget stateIcon(BuildContext context, {double? size, Color? color}) {
    Widget icon = noInfoStateIcon(context, size: size, color: color);
    switch (state) {
      case TaskState.overdue:
        icon = overdueStateIcon(context, size: size, color: color);
        break;
      case TaskState.risk:
        icon = riskStateIcon(context, size: size, color: color);
        break;
      case TaskState.ok:
        icon = okStateIcon(context, size: size, color: color);
        break;
      case TaskState.noInfo:
    }
    return icon;
  }

  String get stateTextTitle {
    String res = loc.task_state_no_info_title;
    switch (state) {
      case TaskState.overdue:
        res = loc.task_state_overdue_title;
        break;
      case TaskState.risk:
        res = loc.task_state_risky_title;
        break;
      case TaskState.ok:
        res = loc.task_state_ok_title;
        break;
      case TaskState.noInfo:
    }
    return res;
  }

  String? get stateTextDetails {
    String? res;

    switch (state) {
      case TaskState.overdue:
        res = '${loc.task_state_overdue_details} ${loc.days_count(totalOverduePeriod.inDays)}';
        break;
      case TaskState.risk:
        res = '${loc.task_state_risky_details} ${loc.days_count(totalRiskPeriod.inDays)}';
        break;
      case TaskState.ok:
      case TaskState.noInfo:
    }
    return res;
  }
}
