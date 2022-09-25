// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_ext_level.dart';
import '../../L1_domain/entities/task_ext_state.dart';
import '../components/colors.dart';
import '../components/icons.dart';
import '../extra/services.dart';
import '../presenters/task_level_presenter.dart';

const _colors = {
  TaskState.overdue: dangerColor,
  TaskState.risk: warningColor,
  TaskState.ok: greenColor,
};

extension TaskStatePresenter on Task {
  Color get stateColor => _colors[state] ?? darkGreyColor;
  Color get subtasksStateColor => _colors[subtasksState] ?? darkGreyColor;

  Widget stateIcon(BuildContext context, {double? size}) {
    final _color = stateColor;
    Widget icon = noInfoStateIcon(context, size: size, color: _color);
    switch (state) {
      case TaskState.overdue:
        icon = overdueStateIcon(context, size: size, color: _color);
        break;
      case TaskState.risk:
        icon = riskStateIcon(context, size: size, color: _color);
        break;
      case TaskState.closable:
      case TaskState.eta:
      case TaskState.ok:
        icon = okStateIcon(context, size: size, color: _color);
        break;
      default:
    }
    return icon;
  }

  Widget subtasksStateIcon(BuildContext context, {double? size}) {
    final _color = subtasksStateColor;
    Widget icon = noInfoStateIcon(context, size: size, color: _color);
    switch (subtasksState) {
      case TaskState.overdue:
        icon = overdueStateIcon(context, size: size, color: _color);
        break;
      case TaskState.risk:
        icon = riskStateIcon(context, size: size, color: _color);
        break;
      default:
    }
    return icon;
  }

  String _durationString(Duration? d) => d != null ? (d.inDays < 1 ? loc.hours_count(d.inHours) : loc.days_count(d.inDays)) : '';
  String _subjects(int count) => count > 0 ? ' ${loc.for_dative} ${dativeSubtasksCount(count)}' : '';

  String get _overdueTitle => '${loc.task_state_overdue_details_prefix} ${_durationString(overduePeriod)}';
  String get _overdueDetails => '${loc.task_state_overdue_details_prefix} ${_durationString(maxOverduePeriod)}${_subjects(overdueSubtasks.length)}';
  String get _riskyTitle => '${loc.task_state_risk_details_prefix} ${_durationString(riskPeriod)}';
  String get _riskyDetails => '${loc.task_state_risk_details_prefix} ${_durationString(subtasksRiskPeriod)}${_subjects(riskySubtasks.length)}';
  String get _etaDetails => '${loc.task_state_eta_details_prefix} ${_durationString(etaPeriod)}';

  String get stateTitle {
    String res = loc.task_state_no_info_title;
    switch (state) {
      case TaskState.future:
        break;
      case TaskState.overdue:
        res = hasOverdue
            ? hasRisk
                ? '${loc.task_state_overdue_risk_details_prefix} $_etaDetails'
                : _overdueTitle
            : _overdueDetails;
        break;
      case TaskState.risk:
        res = hasRisk ? _riskyTitle : _riskyDetails;
        break;

      case TaskState.ok:
        res = isAhead ? loc.task_state_ahead_title_count(_durationString(totalAheadPeriod)) : loc.task_state_ok_title;
        break;
      case TaskState.eta:
        res = _etaDetails;
        break;
      case TaskState.closable:
        res = loc.task_state_closable_title;
        break;
      case TaskState.noDueDate:
        res = loc.task_state_no_due_details;
        break;
      case TaskState.noSubtasks:
        res = subtasksCount(0);
        break;
      case TaskState.noProgress:
        res = loc.task_state_no_progress_details;
        break;
      case TaskState.noInfo:
    }
    return res;
  }

  String get subtasksStateTitle {
    return overdueSubtasks.isNotEmpty
        ? _overdueDetails
        : riskySubtasks.isNotEmpty
            ? _riskyDetails
            : '';
  }

  bool get showState => !closed && (hasSubtasks || isGoal || state != TaskState.noInfo);
  bool get showSubtasksState => !closed && subtasksState != TaskState.noInfo && subtasksStateTitle != stateTitle;
  bool get showTimeChart => !closed && hasDueDate;
}
