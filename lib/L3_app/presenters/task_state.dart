// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_dates.dart';
import '../components/circle.dart';
import '../components/circular_progress.dart';
import '../components/constants.dart';
import '../theme/colors.dart';
import '../views/app/services.dart';
import 'duration.dart';
import 'task_tree.dart';
import 'task_type.dart';

Color stateColor(TaskState state, {Color? defaultColor}) {
  switch (state) {
    case TaskState.OVERDUE:
      return dangerColor;
    case TaskState.RISK:
    case TaskState.TODAY:
      return warningColor;
    case TaskState.CLOSABLE:
    case TaskState.OK:
    case TaskState.AHEAD:
    case TaskState.THIS_WEEK:
      return greenColor;
    case TaskState.IMPORTING:
      return mainColor;
    default:
      return defaultColor ?? f2Color;
  }
}

LinearGradient stateGradient(BuildContext context, TaskState state) {
  final color = stateColor(state).resolve(context);
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0, 0.2, 1],
    colors: [color, color.withAlpha(75), color.withAlpha(0)],
  );
}

Widget stateIconGroup(BuildContext context, TaskState state) {
  final importing = state == TaskState.IMPORTING;
  return SizedBox(
    height: P4,
    width: P2,
    child: Stack(
      children: [
        Positioned(
          left: P,
          top: importing ? P2 : P,
          child: Container(
            decoration: BoxDecoration(gradient: stateGradient(context, state)),
            width: P,
            height: importing ? P2 : P3,
          ),
        ),
        importing ? MTCircularProgress(color: stateColor(state), strokeWidth: 3, size: P2) : MTCircle(size: P2, color: stateColor(state)),
      ],
    ),
  );
}

String groupStateTitle(TaskState groupState) {
  switch (groupState) {
    case TaskState.OVERDUE:
      return loc.state_overdue_title;
    case TaskState.RISK:
      return loc.state_risk_title;
    case TaskState.OK:
      return loc.state_ok_title;
    case TaskState.AHEAD:
      return loc.state_ahead_title;
    case TaskState.ETA:
      return loc.state_eta_title;
    case TaskState.CLOSABLE:
      return loc.state_closable_title;
    case TaskState.FUTURE_START:
      return loc.state_future_title;
    case TaskState.NO_INFO:
    case TaskState.LOW_START:
    case TaskState.NO_SUBTASKS:
    case TaskState.NO_PROGRESS:
      return loc.state_no_info_title;
    case TaskState.TODAY:
      return loc.today_title;
    case TaskState.THIS_WEEK:
      return loc.my_tasks_this_week_title;
    case TaskState.FUTURE_DATE:
      return loc.my_tasks_future_title;
    case TaskState.NO_DUE:
      return loc.my_tasks_no_due_title;
    case TaskState.BACKLOG:
      return loc.backlog;
    case TaskState.IMPORTING:
      return loc.state_importing_title;
    case TaskState.CLOSED:
      return loc.state_closed;
    case TaskState.NO_ANALYTICS:
      return loc.state_no_analytics;
  }
}

extension TaskStatePresenter on Task {
  bool get projectLowStart => project.state == TaskState.LOW_START;
  double? get projectVelocity => project.velocity;

  String _subjects(int count, {bool dative = true}) {
    String res = '';
    if (count > 0) {
      res = dative ? ' ${loc.for_dative} ${dativeSubtasksCount(count)}' : ' ${subtasksCountStr(count)}';
    }
    return res;
  }

  String get _etaDetails => loc.state_eta_duration(etaPeriod!.localizedString);
  String get _lowStartDetails => loc.state_low_start_duration(appController.lowStartThreshold.localizedString);
  String get _noProgressDetails => loc.state_no_progress_details;

  String subtasksStateTitle(int count, TaskState stState) {
    switch (stState) {
      case TaskState.OVERDUE:
        return '${loc.state_overdue_title}${_subjects(count)}';
      case TaskState.RISK:
        return '${loc.state_risk_title}${_subjects(count)}';
      case TaskState.OK:
        return '${loc.state_on_time_title}${_subjects(count)}';
      case TaskState.AHEAD:
        return '${loc.state_ahead_title}${_subjects(count)}';
      case TaskState.ETA:
        return _etaDetails;
      default:
        return loc.state_no_info_title;
    }
  }

  String get stateTitle {
    switch (state) {
      case TaskState.OVERDUE:
        return '${loc.state_overdue_title}${etaPeriod != null ? '. $_etaDetails' : ''}';
      case TaskState.RISK:
        return loc.state_risk_duration(riskPeriod!.localizedString);
      case TaskState.OK:
        return loc.state_on_time_title;
      case TaskState.AHEAD:
        return loc.state_ahead_duration((-riskPeriod!).localizedString);
      case TaskState.ETA:
        return _etaDetails;
      case TaskState.CLOSABLE:
        return loc.state_closable_title;
      case TaskState.NO_SUBTASKS:
        return loc.task_count(0);
      case TaskState.NO_PROGRESS:
        return _noProgressDetails;
      case TaskState.FUTURE_START:
        return loc.state_future_start_duration(beforeStartPeriod.localizedString);
      case TaskState.LOW_START:
        return _lowStartDetails;
      case TaskState.NO_INFO:
        return project.state == TaskState.NO_PROGRESS
            ? _noProgressDetails
            : project.state == TaskState.LOW_START
                ? _lowStartDetails
                : loc.state_no_info_title;
      case TaskState.BACKLOG:
        return loc.backlog;
      case TaskState.CLOSED:
        return loc.state_closed;
      default:
        return '???';
    }
  }

  Duration? get projectStartEtaCalcPeriod => project.calculatedStartDate.add(appController.lowStartThreshold).difference(DateTime.now());
}
