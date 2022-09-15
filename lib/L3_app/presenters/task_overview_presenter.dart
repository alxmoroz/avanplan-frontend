// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_ext_state.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../extra/services.dart';

const _colors = {
  TaskState.overdue: dangerColor,
  TaskState.risk: lightWarningColor,
  TaskState.ok: greenColor,
};

const _bgColors = {
  TaskState.overdue: bgLightWarningColor,
  TaskState.risk: bgLightWarningColor,
  TaskState.ok: bgGreenColor,
};

extension TaskStatePresenter on Task {
  Color? get stateColor => _colors[state];
  Color? get stateBgColor => _bgColors[state];

  Color? get overdueColor => _colors[TaskState.overdue];
  Color? get riskColor => _colors[TaskState.risk];
  Color? get okColor => _colors[TaskState.ok];

  Widget stateIcon(BuildContext context, {double? size, Color? color}) {
    Widget icon = noInfoStateIcon(context, size: size, color: color);
    switch (state) {
      case TaskState.overdue:
        icon = overdueStateIcon(context, size: size, color: color);
        break;
      case TaskState.risk:
        icon = riskStateIcon(context, size: size, color: color);
        break;
      case TaskState.closable:
      case TaskState.ok:
        icon = okStateIcon(context, size: size, color: color);
        break;
      case TaskState.noDueDate:
      case TaskState.noSubtasks:
      case TaskState.noProgress:
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
      case TaskState.closable:
        res = loc.task_state_closable_title;
        break;
      case TaskState.ok:
        res = loc.task_state_ok_title;
        break;
      case TaskState.noDueDate:
      case TaskState.noSubtasks:
      case TaskState.noProgress:
      case TaskState.noInfo:
    }
    return res;
  }

  String durationString(Duration d) => d.inDays < 1 ? loc.hours_count(d.inHours) : loc.days_count(d.inDays);

  String get overDueDetails => '${loc.task_state_overdue_details} ${durationString(totalOverduePeriod)}';
  String get riskyDetails => '${loc.task_state_risky_details} ${durationString(totalRiskPeriod)}';

  String? get stateTextDetails {
    String? res;

    switch (state) {
      case TaskState.overdue:
        res = overDueDetails;
        break;
      case TaskState.risk:
        res = riskyDetails;
        break;
      case TaskState.noDueDate:
        res = loc.task_state_no_due_details;
        break;
      case TaskState.noSubtasks:
        res = loc.task_state_no_tasks_goal_details;
        break;
      case TaskState.noProgress:
        res = loc.task_state_no_progress_details;
        break;

      case TaskState.closable:
      case TaskState.ok:
      case TaskState.noInfo:
    }
    return res;
  }
}
