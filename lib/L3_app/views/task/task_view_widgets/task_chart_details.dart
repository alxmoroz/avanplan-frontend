// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_bottom_sheet.dart';
import '../../../components/mt_close_button.dart';
import '../../../components/mt_page.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/date_presenter.dart';
import '../../../presenters/state_presenter.dart';
import '../task_charts/task_speed_chart.dart';
import '../task_charts/task_time_chart.dart';
import '../task_charts/task_volume_chart.dart';

Future<String?> showChartsDetailsDialog(BuildContext context, Task task) async {
  return await showModalBottomSheet<String?>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (_) => MTBottomSheet(TaskChartDetails(task)),
  );
}

class TaskChartDetails extends StatelessWidget {
  const TaskChartDetails(this.task);
  @protected
  final Task task;

  Widget _textRow(String t1, String t2, {Color? color}) => Row(children: [
        Expanded(child: LightText(t1, height: 1.1, sizeScale: 1.1)),
        H4(t2, color: color, padding: EdgeInsets.only(top: onePadding / 6, bottom: onePadding / 6))
      ]);

  int get _volumeDelta => task.planVolume != null ? (task.closedLeafTasksCount - task.planVolume!.round()) : 0;
  int get _speedDelta => task.targetSpeed != null ? ((task.projectOrWSSpeed - task.targetSpeed!) * secondsInMonth).round() : 0;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return MTPage(
      navBar: navBar(context, leading: MTCloseButton(), title: loc.charts_details_title, bgColor: backgroundColor),
      body: SafeArea(
        bottom: false,
        // top: false,
        child: ListView(padding: padding.add(EdgeInsets.all(onePadding)), children: [
          if (task.showSpeedVolumeCharts) ...[
            /// объем
            H3(loc.charts_volume_title, padding: EdgeInsets.only(bottom: onePadding)),
            Row(children: [
              TaskVolumeChart(task),
              SizedBox(width: onePadding),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  _textRow(loc.charts_volume_total_label, '${task.leafTasksCount}'),
                  _textRow(loc.state_opened, '${task.openedLeafTasksCount}'),
                  _textRow(loc.state_closed, '${task.closedLeafTasksCount}'),
                  if (task.planVolume != null) ...[
                    SizedBox(height: onePadding),
                    _textRow(loc.charts_volume_plan_label, '${task.planVolume!.round()}'),
                    if (_volumeDelta != 0)
                      _textRow(
                        _volumeDelta > 0 ? loc.charts_delta_ahead_label : loc.charts_delta_lag_label,
                        '${_volumeDelta.abs()}',
                        color: _volumeDelta > 0 ? greenColor : warningColor,
                      ),
                  ],
                ]),
              ),
            ]),

            /// скорость
            SizedBox(height: onePadding),
            H3(loc.charts_speed_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
            Row(children: [
              TaskSpeedChart(task),
              SizedBox(width: onePadding),
              Expanded(
                child: Column(children: [
                  _textRow(loc.charts_speed_project_label, '${(task.projectOrWSSpeed * secondsInMonth).round()}'),
                  if (task.targetSpeed != null) _textRow(loc.charts_speed_target_label, '${(task.targetSpeed! * secondsInMonth).round()}'),
                  if (_speedDelta != 0)
                    _textRow(
                      _speedDelta > 0 ? loc.charts_delta_ahead_label : loc.charts_delta_lag_label,
                      '${_speedDelta.abs()}',
                      color: _speedDelta > 0 ? greenColor : warningColor,
                    ),
                ]),
              ),
            ]),
          ],

          /// срок
          if (task.showTimeChart) ...[
            H3(loc.charts_timings_title, padding: EdgeInsets.symmetric(vertical: onePadding)),
            TaskTimeChart(task),
            SizedBox(height: onePadding / 2),
            if (task.elapsedPeriod != null) _textRow(loc.charts_timings_elapsed_label, '${loc.days_count(task.elapsedPeriod!.inDays)}'),
            if (task.leftPeriod != null) _textRow(loc.charts_timings_left_label, '${loc.days_count(task.leftPeriod!.inDays)}'),
            if (task.etaPeriod != null) _textRow(loc.charts_timings_eta_label, '${loc.days_count(task.etaPeriod!.inDays)}'),
            if (task.riskPeriod != null) H4(task.stateTitle, padding: EdgeInsets.only(top: onePadding / 2)),
          ],
        ]),
      ),
    );
  }
}
