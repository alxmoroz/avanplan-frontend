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

const _colors = {
  TaskState.overdue: dangerColor,
  TaskState.risk: warningColor,
  TaskState.ok: greenColor,
};

Color colorForState(TaskState state) => _colors[state] ?? darkGreyColor;

Widget iconForState(BuildContext context, TaskState state, {double? size}) {
  final _color = colorForState(state);
  switch (state) {
    case TaskState.overdue:
      return overdueStateIcon(context, size: size, color: _color);
    case TaskState.risk:
      return riskStateIcon(context, size: size, color: _color);
    case TaskState.closable:
    case TaskState.eta:
    case TaskState.ok:
      return okStateIcon(context, size: size, color: _color);
    case TaskState.closed:
      return doneIcon(context, true, size: size, color: _color);
    case TaskState.opened:
    case TaskState.future:
      return openedStateIcon(context, size: size, color: _color);
    default:
      return noInfoStateIcon(context, size: size, color: _color);
  }
}

extension TaskStatePresenter on Task {
  Widget stateIcon(BuildContext context, {double? size}) => iconForState(context, state, size: size);

  String _subjects(int count) => count > 0 ? ' ${loc.for_dative} ${dativeSubtasksCount(count)}' : '';

  String get _overdueTitle => '${loc.task_state_overdue_duration(overduePeriod!.localizedString)}';
  String get _overdueDetails => '${loc.task_state_overdue_duration(maxOverduePeriod.localizedString)}${_subjects(overdueSubtasks.length)}';
  String get _riskyTitle => '${loc.task_state_risk_duration(riskPeriod!.localizedString)}';
  String get _riskyDetails => '${loc.task_state_risk_duration(subtasksRiskPeriod.localizedString)}${_subjects(riskySubtasks.length)}';
  String get _etaDetails => '${loc.task_state_eta_duration(etaPeriod!.localizedString)}';

  String get stateTitle {
    switch (state) {
      case TaskState.overdue:
        return hasOverdue
            ? hasRisk
                ? '${loc.task_state_overdue_title}. $_etaDetails'
                : _overdueTitle
            : _overdueDetails;
      case TaskState.risk:
        return hasRisk ? _riskyTitle : _riskyDetails;
      case TaskState.ok:
        return isAhead ? loc.task_state_ahead_duration(totalAheadPeriod.localizedString) : loc.task_state_ok_title;
      case TaskState.eta:
        return _etaDetails;
      case TaskState.closable:
        return loc.task_state_closable_title;
      case TaskState.noDueDate:
        return loc.task_state_no_due_details;
      case TaskState.noSubtasks:
        return subtasksCount(0);
      case TaskState.noProgress:
        return loc.task_state_no_progress_details;
      case TaskState.future:
        return loc.task_state_future_duration(startPeriod.localizedString);
      default:
        return loc.task_state_no_info_title;
    }
  }

  String groupStateTitle(TaskState groupState) {
    switch (groupState) {
      case TaskState.overdue:
        return loc.task_state_overdue_title;
      case TaskState.risk:
        return loc.task_state_risk_title;
      case TaskState.ok:
        return loc.task_state_ok_title;
      case TaskState.eta:
        return loc.task_state_eta_title;
      case TaskState.closable:
        return loc.task_state_closable_title;
      case TaskState.noDueDate:
        return loc.task_state_no_due_details;
      case TaskState.noSubtasks:
        return grandchildrenCount(0);
      case TaskState.noProgress:
        return loc.task_state_no_progress_details;
      case TaskState.closed:
        return loc.task_state_closed;
      case TaskState.future:
        return loc.task_state_future_title;
      case TaskState.opened:
        return loc.task_state_opened;
    }
  }

  bool get showState => !closed && (hasSubtasks || isGoal || state != TaskState.opened);
  bool get canShowTimeChart => !closed && hasDueDate;
  bool get canShowSpeedVolumeCharts => canShowTimeChart;
}
