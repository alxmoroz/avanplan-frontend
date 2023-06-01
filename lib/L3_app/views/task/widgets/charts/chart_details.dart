// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_bottom_sheet.dart';
import '../../../../components/mt_close_button.dart';
import '../../../../components/navbar.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/duration_presenter.dart';
import '../../../../presenters/task_state_presenter.dart';
import '../../../../presenters/task_view_presenter.dart';
import 'timing_chart.dart';
import 'velocity_chart.dart';
import 'volume_chart.dart';

Future showChartsDetailsDialog(Task task) async {
  return await showModalBottomSheet<void>(
    context: rootKey.currentContext!,
    isScrollControlled: true,
    builder: (_) => TaskChartDetails(task),
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
    return MTBottomSheet(
      topBar: navBar(
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
        child: ListView(
          shrinkWrap: true,
          padding: padding.copyWith(left: P, right: P),
          children: [
            if (task.canShowVelocityVolumeCharts) ...[
              /// объем
              H4(loc.chart_volume_title),
              const SizedBox(height: P),
              Row(
                children: [
                  Flexible(child: TaskVolumeChart(task)),
                  const SizedBox(width: P),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
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
                      ],
                    ),
                  ),
                ],
              ),

              /// скорость
              const SizedBox(height: P2),
              H4(loc.chart_velocity_title),
              const SizedBox(height: P),
              Row(children: [
                Flexible(child: VelocityChart(task)),
                if (!task.projectLowStart) ...[
                  const SizedBox(width: P),
                  Flexible(
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
            if (task.canShowTimeChart) ...[
              H4(loc.chart_timing_title),
              const SizedBox(height: P),
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
          ],
        ),
      ),
    );
  }
}
