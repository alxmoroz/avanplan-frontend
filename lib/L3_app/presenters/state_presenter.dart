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
    case TaskState.overdueSubtasks:
      return OverdueIcon(size: size, color: dangerColor);
    case TaskState.risk:
    case TaskState.riskSubtasks:
      return RiskIcon(size: size, color: warningColor);
    case TaskState.closable:
    case TaskState.eta:
    case TaskState.ok:
    case TaskState.okSubtasks:
    case TaskState.ahead:
    case TaskState.aheadSubtasks:
      return OkIcon(size: size, color: greenColor);
    case TaskState.closed:
      return DoneIcon(true, size: size, color: darkGreyColor);
    case TaskState.opened:
      return PlayIcon(size: size, color: darkGreyColor);
    case TaskState.future:
      return PauseIcon(size: size, color: darkGreyColor);
    case TaskState.backlog:
      return BacklogIcon(size: size, color: darkGreyColor);
    case TaskState.noSubtasks:
    case TaskState.noProgress:
    case TaskState.noInfo:
      return NoInfoIcon(size: size, color: darkGreyColor);
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
        return '${loc.state_overdue_title}. $_etaDetails';
      case TaskState.overdueSubtasks:
        return '${loc.state_overdue_title}${_subjects(overdueSubtasks.length)}';
      case TaskState.risk:
        return '${loc.state_risk_duration(riskPeriod!.localizedString)}';
      case TaskState.riskSubtasks:
        return '${loc.state_risk_title}${_subjects(riskySubtasks.length)}';
      case TaskState.ok:
        return loc.state_ok_title;
      case TaskState.okSubtasks:
        return '${loc.state_ok_title}${_subjects(okSubtasks.length)}';
      case TaskState.ahead:
        return loc.state_ahead_duration((-riskPeriod!).localizedString);
      case TaskState.aheadSubtasks:
        return '${loc.state_ahead_title}${_subjects(aheadSubtasks.length, dative: false)}';
      case TaskState.eta:
        return _etaDetails;
      case TaskState.closable:
        return loc.state_closable_title;
      case TaskState.noSubtasks:
        return subtasksCount(0);
      case TaskState.noProgress:
        return loc.state_no_progress_details;
      case TaskState.future:
        return loc.state_future_duration(startPeriod.localizedString);
      case TaskState.backlog:
        return loc.backlog;
      case TaskState.opened:
        return loc.state_opened;
      case TaskState.noInfo:
        return '${loc.state_no_info_title}${_subjects(openedSubtasks.where((t) => !t.isBacklog).length)}';
      case TaskState.closed:
        return loc.state_closed;
    }
  }

  String groupStateTitle(TaskState groupState) {
    switch (groupState) {
      case TaskState.overdue:
      case TaskState.overdueSubtasks:
        return loc.state_overdue_title;
      case TaskState.risk:
      case TaskState.riskSubtasks:
        return loc.state_risk_title;
      case TaskState.ok:
      case TaskState.okSubtasks:
        return loc.state_ok_title;
      case TaskState.ahead:
      case TaskState.aheadSubtasks:
        return loc.state_ahead_title;
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
      case TaskState.backlog:
        return loc.backlog;
      case TaskState.opened:
        return loc.state_opened;
      case TaskState.noInfo:
        return loc.state_no_info_title;
    }
  }

  bool get showState => !closed && (state != TaskState.opened);
  bool get canShowTimeChart => showState && hasDueDate;
  bool get canShowSpeedVolumeCharts => showState && !isWorkspace;
}
