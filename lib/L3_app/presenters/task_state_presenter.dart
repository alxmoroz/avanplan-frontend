// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../main.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_level.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/images.dart';
import '../components/mt_circle.dart';
import '../extra/services.dart';
import '../presenters/duration_presenter.dart';
import '../presenters/task_level_presenter.dart';

Color stateColor(String state) {
  switch (state) {
    case TaskState.OVERDUE:
      return dangerColor;
    case TaskState.RISK:
    case TaskState.TODAY:
      return warningColor;
    case TaskState.CLOSABLE:
    case TaskState.OK:
    case TaskState.THIS_WEEK:
      return greenColor;
    default:
      return lightGreyColor;
  }
}

Widget imageForState(String state, {double? size}) {
  String name = ImageNames.noInfo;
  switch (state) {
    case TaskState.OVERDUE:
      name = ImageNames.overdue;
      break;
    case TaskState.RISK:
      name = ImageNames.risk;
      break;
    case TaskState.CLOSABLE:
    case TaskState.OK:
    case TaskState.AHEAD:
    case TaskState.CLOSED:
      name = ImageNames.ok;
      break;
    default:
  }
  return MTImage(name, size: size);
}

LinearGradient stateGradient(String state) {
  final color = stateColor(state).resolve(rootKey.currentContext!);
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0, 0.2, 1],
    colors: [color, color.withAlpha(75), color.withAlpha(0)],
  );
}

Widget stateIconGroup(String state) => SizedBox(
      height: P2,
      width: P,
      child: Stack(
        children: [
          MTCircle(size: P, color: stateColor(state)),
          Positioned(
            left: P_2,
            top: P_2,
            child: Container(
              decoration: BoxDecoration(gradient: stateGradient(state)),
              width: P_2,
              height: P + P_2,
            ),
          ),
        ],
      ),
    );

extension TaskStatePresenter on Task {
  String _subjects(int count, {bool dative = true}) {
    String res = '';
    if (count > 0) {
      res = dative ? ' ${loc.for_dative} ${dativeSubtasksCount(count)}' : ' ${subtasksCount(count)}';
    }
    return res;
  }

  String get _etaDetails => '${loc.state_eta_duration(etaPeriod!.localizedString)}';

  String get stateTitle {
    switch (state) {
      case TaskState.OVERDUE:
        return '${loc.state_overdue_title}${etaPeriod != null ? '. $_etaDetails' : ''}';
      case TaskState.RISK:
        return '${loc.state_risk_duration(riskPeriod!.localizedString)}';
      case TaskState.OK:
        return loc.state_on_time_title;
      case TaskState.AHEAD:
        return loc.state_ahead_duration((-riskPeriod!).localizedString);
      case TaskState.ETA:
        return _etaDetails;
      case TaskState.CLOSABLE:
        return loc.state_closable_title;
      case TaskState.NO_SUBTASKS:
        return subtasksCount(0);
      case TaskState.NO_PROGRESS:
        return loc.state_no_progress_details;
      case TaskState.FUTURE_START:
        return loc.state_future_start_duration(beforeStartPeriod.localizedString);
      case TaskState.OPENED:
        return loc.state_opened;
      case TaskState.NO_INFO:
        return projectLowStart ? loc.state_low_start_duration(lowStartThreshold.localizedString) : loc.state_no_info_title;
      case TaskState.CLOSED:
        return loc.state_closed;
      default:
        return loc.state_no_info_title;
    }
  }

  String get subtasksStateTitle {
    switch (subtasksState) {
      case TaskState.OVERDUE:
        return '${loc.state_overdue_title}${_subjects(overdueSubtasks.length)}';
      case TaskState.RISK:
        return '${loc.state_risk_title}${_subjects(riskySubtasks.length)}';
      case TaskState.OK:
        return '${loc.state_on_time_title}${_subjects(okSubtasks.length)}';
      case TaskState.ETA:
        return _etaDetails;
      default:
        return '${loc.state_no_info_title}${_subjects(openedSubtasks.length)}';
    }
  }

  String get overallStateTitle {
    final st = state;
    final subSt = subtasksState;
    final stTitle = stateTitle;

    return ![TaskState.NO_INFO, TaskState.ETA].contains(st)
        ? stTitle
        : subSt != TaskState.NO_INFO
            ? subtasksStateTitle
            : stTitle;
  }

  String groupStateTitle(String groupState) {
    switch (groupState) {
      case TaskState.OVERDUE:
        return loc.state_overdue_title;
      case TaskState.RISK:
        return loc.state_risk_title;
      case TaskState.OK:
        return loc.state_ok_title;
      case TaskState.AHEAD:
        return loc.state_ok_title;
      case TaskState.ETA:
        return loc.state_eta_title;
      case TaskState.CLOSABLE:
        return loc.state_closable_title;
      case TaskState.NO_SUBTASKS:
        return grandchildrenCount(0);
      case TaskState.NO_PROGRESS:
        return loc.state_no_progress_details;
      case TaskState.CLOSED:
        return loc.state_closed;
      case TaskState.FUTURE_START:
        return loc.state_future_title;
      case TaskState.OPENED:
        return loc.state_opened;
      case TaskState.NO_INFO:
        return loc.state_no_info_title;
      case TaskState.TODAY:
        return loc.my_tasks_today_title;
      case TaskState.THIS_WEEK:
        return loc.my_tasks_this_week_title;
      case TaskState.FUTURE_DUE:
        return loc.my_tasks_future_title;
      case TaskState.NO_DUE:
        return loc.my_tasks_no_due_title;
      default:
        return '';
    }
  }

  bool get canShowState => !closed && !isLeaf;
  bool get canShowRecommendsEta => !isRoot && [TaskState.NO_SUBTASKS, TaskState.NO_PROGRESS].contains(overallState);
}
