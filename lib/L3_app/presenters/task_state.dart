// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../main.dart';
import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_state.dart';
import '../../L1_domain/entities_extensions/task_stats.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/images.dart';
import '../components/mt_circle.dart';
import '../extra/services.dart';
import '../presenters/duration.dart';
import '../presenters/task_filter.dart';
import '../presenters/task_tree.dart';
import '../presenters/task_type.dart';

Color stateColor(TaskState state) {
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
    default:
      return fgL2Color;
  }
}

Widget imageForState(TaskState state, {double? size}) {
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
    case TaskState.CLOSED:
      return loc.state_closed;
    case TaskState.FUTURE_START:
    case TaskState.NO_INFO:
    case TaskState.LOW_START:
    case TaskState.NO_SUBTASKS:
    case TaskState.NO_PROGRESS:
      return loc.state_no_info_title;
    case TaskState.TODAY:
      return loc.my_tasks_today_title;
    case TaskState.THIS_WEEK:
      return loc.my_tasks_this_week_title;
    case TaskState.FUTURE_DUE:
      return loc.my_tasks_future_title;
    case TaskState.NO_DUE:
      return loc.my_tasks_no_due_title;
  }
}

TaskState attentionalState(List<MapEntry<TaskState, List<Task>>> groups) => groups.isNotEmpty ? groups.first.key : TaskState.NO_SUBTASKS;
List<Task> attentionalTasks(List<MapEntry<TaskState, List<Task>>> groups) => groups.isNotEmpty &&
        [
          TaskState.OVERDUE,
          TaskState.RISK,
          TaskState.OK,
          TaskState.AHEAD,
        ].contains(groups.first.key)
    ? groups.first.value
    : [];

extension TaskStatePresenter on Task {
  List<Task> get attentionalSubtasks => attentionalTasks(subtaskGroups);
  TaskState get subtasksState => attentionalState(subtaskGroups);

  String _subjects(int count, {bool dative = true}) {
    String res = '';
    if (count > 0) {
      res = dative ? ' ${loc.for_dative} ${dativeSubtasksCount(count)}' : ' ${subtasksCount(count)}';
    }
    return res;
  }

  String get _etaDetails => '${loc.state_eta_duration(etaPeriod!.localizedString)}';
  String get _lowStartDetails => loc.state_low_start_duration(serviceSettingsController.lowStartThreshold.localizedString);
  String get _noProgressDetails => loc.state_no_progress_details;

  String get _subtasksStateTitle {
    final count = attentionalSubtasks.isNotEmpty ? attentionalSubtasks.length : 0;
    switch (subtasksState) {
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
        return loc.task_count(0);
      case TaskState.NO_PROGRESS:
        return _noProgressDetails;
      case TaskState.FUTURE_START:
        return loc.state_future_start_duration(beforeStartPeriod.localizedString);
      case TaskState.LOW_START:
        return _lowStartDetails;
      case TaskState.NO_INFO:
        return project!.state == TaskState.NO_PROGRESS
            ? _noProgressDetails
            : project!.state == TaskState.LOW_START
                ? _lowStartDetails
                : loc.state_no_info_title;
      case TaskState.CLOSED:
        return loc.state_closed;
      default:
        return '???';
    }
  }

  bool get canShowRecommendsEta => project!.state == TaskState.NO_PROGRESS || state == TaskState.NO_SUBTASKS;
  Duration? get projectStartEtaCalcPeriod => project!.calculatedStartDate.add(serviceSettingsController.lowStartThreshold).difference(DateTime.now());

  TaskState get overallState => isTask
      ? leafState
      : attentionalSubtasks.isNotEmpty && !hasDueDate
          ? subtasksState
          : state;

  String get overallStateTitle => isTask || (attentionalSubtasks.isEmpty || hasDueDate) ? stateTitle : _subtasksStateTitle;
}
