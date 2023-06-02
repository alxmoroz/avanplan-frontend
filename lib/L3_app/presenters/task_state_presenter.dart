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

Color stateColor(TaskState state) {
  switch (state) {
    case TaskState.overdue:
      return dangerColor;
    case TaskState.risk:
      return warningColor;
    case TaskState.closable:
    case TaskState.ok:
      return greenColor;
    default:
      return lightGreyColor;
  }
}

Widget imageForState(TaskState state, {double? size}) {
  String name = ImageNames.noInfo;
  switch (state) {
    case TaskState.overdue:
      name = ImageNames.overdue;
      break;
    case TaskState.risk:
      name = ImageNames.risk;
      break;
    case TaskState.closable:
    case TaskState.ok:
      name = ImageNames.ok;
      break;
    case TaskState.closed:
      name = ImageNames.done;
      break;
    default:
  }
  return MTImage(name, size: size);
}

LinearGradient stateGradient(TaskState state) {
  final color = stateColor(state).resolve(rootKey.currentContext!);
  return LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    stops: const [0, 0.2, 1],
    colors: [color, color.withAlpha(75), color.withAlpha(0)],
  );
}

Widget stateIconGroup(TaskState state) => SizedBox(
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
      case TaskState.overdue:
        return '${loc.state_overdue_title}${etaPeriod != null ? '. $_etaDetails' : ''}';
      case TaskState.risk:
        return '${loc.state_risk_duration(riskPeriod!.localizedString)}';
      case TaskState.ok:
        return isAhead ? loc.state_ahead_duration((-riskPeriod!).localizedString) : loc.state_on_time_title;
      case TaskState.eta:
        return _etaDetails;
      case TaskState.closable:
        return loc.state_closable_title;
      case TaskState.noSubtasks:
        return subtasksCount(0);
      case TaskState.noProgress:
        return loc.state_no_progress_details;
      case TaskState.future:
        return loc.state_future_duration(beforeStartPeriod.localizedString);
      case TaskState.opened:
        return loc.state_opened;
      case TaskState.noInfo:
        return projectLowStart ? loc.state_low_start_duration(lowStartThreshold.localizedString) : loc.state_no_info_title;
      case TaskState.closed:
        return loc.state_closed;
    }
  }

  String get subtasksStateTitle {
    switch (subtasksState) {
      case TaskState.overdue:
        return '${loc.state_overdue_title}${_subjects(overdueSubtasks.length)}';
      case TaskState.risk:
        return '${loc.state_risk_title}${_subjects(riskySubtasks.length)}';
      case TaskState.ok:
        return '${loc.state_on_time_title}${_subjects(okSubtasks.length)}';
      case TaskState.eta:
        return _etaDetails;
      default:
        return '${loc.state_no_info_title}${_subjects(openedSubtasks.length)}';
    }
  }

  String get overallStateTitle {
    final st = state;
    final subSt = subtasksState;
    final stTitle = stateTitle;

    return ![TaskState.noInfo, TaskState.eta].contains(st)
        ? stTitle
        : subSt != TaskState.noInfo
            ? subtasksStateTitle
            : stTitle;
  }

  String groupStateTitle(TaskState groupState) {
    switch (groupState) {
      case TaskState.overdue:
        return loc.state_overdue_title;
      case TaskState.risk:
        return loc.state_risk_title;
      case TaskState.ok:
        return loc.state_ok_title;
      case TaskState.eta:
        return loc.state_eta_title;
      case TaskState.closable:
        return loc.state_closable_title;
      case TaskState.noSubtasks:
        return grandchildrenCount(0);
      case TaskState.noProgress:
        return loc.state_no_progress_details;
      case TaskState.closed:
        return loc.state_closed;
      case TaskState.future:
        return loc.state_future_title;
      case TaskState.opened:
        return loc.state_opened;
      case TaskState.noInfo:
        return loc.state_no_info_title;
    }
  }

  bool get canShowState => !closed && (hasSubtasks || isProject || isGoal);
  bool get canShowRecommendsEta => !isRoot && [TaskState.noSubtasks, TaskState.noProgress].contains(overallState);
}
