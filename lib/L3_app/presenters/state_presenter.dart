// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/usecases/task_ext_level.dart';
import '../../L1_domain/usecases/task_ext_state.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../extra/services.dart';
import '../presenters/duration_presenter.dart';
import '../presenters/task_level_presenter.dart';

Widget iconForState(TaskState state, {double? size}) {
  switch (state) {
    case TaskState.overdue:
      return RiskIcon(size: size, color: dangerColor);
    case TaskState.risk:
      return RiskIcon(size: size, color: warningColor);
    case TaskState.closable:
    case TaskState.ok:
      return OkIcon(size: size, color: greenColor);
    case TaskState.closed:
      return DoneIcon(true, size: size, color: lightGreyColor);
    case TaskState.opened:
    case TaskState.eta:
      return PlayIcon(size: size, color: lightGreyColor);
    case TaskState.future:
      return PauseIcon(size: size, color: lightGreyColor);
    case TaskState.noSubtasks:
    case TaskState.noProgress:
    case TaskState.noInfo:
      return NoInfoIcon(size: size, color: lightGreyColor);
  }
}

extension TaskStatePresenter on Task {
  Widget stateIcon({double? size}) => iconForState(state, size: size);

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
        return loc.state_no_info_title;
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

  bool get showState => !closed && (hasSubtasks || isProject || isGoal);
  bool get showRecommendsEta => !isWorkspace && [TaskState.noInfo, TaskState.noSubtasks, TaskState.noProgress].contains(overallState);
  bool get showTimeChart => !isWorkspace && showState && (hasDueDate || hasEtaDate);
  bool get showVelocityVolumeCharts => !isWorkspace && !showRecommendsEta && showState;
  bool get showChartDetails => showVelocityVolumeCharts || showTimeChart;
}
