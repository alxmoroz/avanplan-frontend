// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_stats.dart';
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

Color? stateColor(TaskState state) => _colors[state];
Color? stateBgColor(TaskState state) => _bgColors[state];

Widget stateIcon(BuildContext context, Task task, {double? size, Color? color}) {
  Widget icon = noInfoStateIcon(context, size: size, color: color);
  switch (task.state) {
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

String stateTextTitle(Task task) {
  String res = loc.task_state_no_info_title;
  switch (task.state) {
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

String overdueStateTextDetails(Duration overduePeriod) => '${loc.task_state_overdue_details} ${loc.common_days_count(overduePeriod.inDays)}';

String riskStateTextDetails(Duration etaRiskPeriod) => '${loc.task_state_risky_details} ${loc.common_days_count(etaRiskPeriod.inDays)}';
