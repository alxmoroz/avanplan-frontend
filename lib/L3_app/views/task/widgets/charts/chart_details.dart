// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_bottom_sheet.dart';
import '../../../../components/mt_close_button.dart';
import '../../../../components/mt_page.dart';
import '../../../../components/navbar.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/duration_presenter.dart';
import '../../../../presenters/state_presenter.dart';
import 'timing_chart.dart';
import 'velocity_chart.dart';
import 'volume_chart.dart';

Future showChartsDetailsDialog(BuildContext context, Task task) async {
  return await showModalBottomSheet<void>(
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
        H4(t2, color: color, padding: const EdgeInsets.only(top: P / 6, bottom: P / 6))
      ]);

  int get _volumeDelta => task.planVolume != null ? (task.closedLeafTasksCount - task.planVolume!.round()) : 0;
  double get _velocity => task.projectVelocity ?? 0;
  int get _velocityDelta => task.targetVelocity != null && _velocity > 0 ? ((_velocity - task.targetVelocity!) * daysPerMonth).round() : 0;
  int get _timeDelta => task.leftPeriod!.inDays;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return MTPage(
      navBar: navBar(
        context,
        leading: MTCloseButton(),
        middle: Column(children: [
          const SizedBox(height: P_6),
          LightText(loc.chart_details_title),
          MediumText(task.title, maxLines: 1),
        ]),
        trailing: const SizedBox(width: P * 4),
        bgColor: backgroundColor,
      ),
      body: SafeArea(
        bottom: false,
        // top: false,
        child: ListView(padding: padding.add(const EdgeInsets.all(P)), children: [
          if (task.showVelocityVolumeCharts) ...[
            /// объем
            H3(loc.chart_volume_title, padding: const EdgeInsets.only(bottom: P)),
            Row(children: [
              Expanded(child: TaskVolumeChart(task)),
              const SizedBox(width: P_2),
              Expanded(
                child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                  _textRow(loc.chart_volume_total_label, '${task.leafTasksCount}'),
                  _textRow(loc.state_opened, '${task.openedLeafTasksCount}'),
                  _textRow(loc.state_closed, '${task.closedLeafTasksCount}'),
                  if (task.planVolume != null) ...[
                    const SizedBox(height: P),
                    _textRow(loc.chart_volume_plan_label, '${task.planVolume!.round()}'),
                    if (_volumeDelta != 0)
                      _textRow(
                        _volumeDelta > 0 ? loc.chart_delta_ahead_label : loc.chart_delta_lag_label,
                        '${_volumeDelta.abs()}',
                        color: _volumeDelta > 0 ? greenColor : warningColor,
                      ),
                  ],
                ]),
              ),
            ]),

            /// скорость
            const SizedBox(height: P),
            H3(loc.chart_velocity_title, padding: const EdgeInsets.symmetric(vertical: P)),
            Row(children: [
              Expanded(child: VelocityChart(task)),
              if (!task.projectLowStart) ...[
                const SizedBox(width: P_2),
                Expanded(
                  child: Column(children: [
                    _textRow(loc.chart_velocity_project_label, '${(_velocity * daysPerMonth).round()}'),
                    if (task.targetVelocity != null) _textRow(loc.chart_velocity_target_label, '${(task.targetVelocity! * daysPerMonth).round()}'),
                    if (_velocityDelta != 0)
                      _textRow(
                        _velocityDelta > 0 ? loc.chart_delta_ahead_label : loc.chart_delta_lag_label,
                        '${_velocityDelta.abs()}',
                        color: _velocityDelta > 0 ? greenColor : warningColor,
                      ),
                  ]),
                ),
              ],
            ]),
          ],

          /// срок
          if (task.showTimeChart) ...[
            H3(loc.chart_timing_title, padding: const EdgeInsets.symmetric(vertical: P)),
            TimingChart(task),
            const SizedBox(height: P_2),
            if (!task.isFuture) _textRow(loc.chart_timing_elapsed_label, '${loc.days_count(task.elapsedPeriod.inDays)}'),
            if (task.leftPeriod != null)
              _textRow(
                _timeDelta >= 0 ? loc.chart_timing_left_label : loc.state_overdue_title,
                '${loc.days_count(_timeDelta.abs())}',
                color: _timeDelta > 0 ? null : warningColor,
              ),
            if (task.etaPeriod != null) _textRow(loc.chart_timing_eta_label, '${loc.days_count(task.etaPeriod!.inDays)}'),
            if (task.riskPeriod != null) H4(task.stateTitle, padding: const EdgeInsets.only(top: P_2)),
          ],
        ]),
      ),
    );
  }
}
