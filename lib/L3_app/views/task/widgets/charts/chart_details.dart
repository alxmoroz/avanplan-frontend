// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_dialog.dart';
import '../../../../components/mt_toolbar.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/duration_presenter.dart';
import '../../../../presenters/task_state_presenter.dart';
import '../../../../presenters/task_view_presenter.dart';
import '../../../../presenters/ws_presenter.dart';
import 'timing_chart.dart';
import 'velocity_chart.dart';
import 'volume_chart.dart';

Future showChartsDetailsDialog(Task task) async => await showMTDialog<void>(TaskChartDetails(task));

class TaskChartDetails extends StatelessWidget {
  const TaskChartDetails(this.task);
  @protected
  final Task task;

  Widget _textRow(String t1, String t2, {Color? color}) => Row(children: [
        Expanded(child: LightText(t1, height: 1.1, sizeScale: 1.1)),
        H3(t2, color: color, padding: const EdgeInsets.only(top: P / 6, bottom: P / 6))
      ]);

  int get _timeDelta => task.leftPeriod!.inDays;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.chart_details_title),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: P),
        color: lightBackgroundColor.resolve(context),
        child: ListView(
          shrinkWrap: true,
          children: [
            if (task.canShowVelocityVolumeCharts) ...[
              /// объем
              H3('${loc.chart_volume_title}, ${task.ws.estimateUnitCode}'),
              const SizedBox(height: P),
              Row(
                children: [
                  Flexible(child: TaskVolumeChart(task)),
                  const SizedBox(width: P),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _textRow(loc.chart_volume_total_label, '${task.totalVolume.round()}'),
                        _textRow(loc.state_closed, '${(task.closedVolume ?? 0).round()}'),
                        _textRow(loc.state_opened, '${(task.openedVolume ?? 0).round()}'),
                      ],
                    ),
                  ),
                ],
              ),

              /// скорость
              const SizedBox(height: P2),
              H3(loc.chart_velocity_title),
              const SizedBox(height: P),
              Row(children: [
                Flexible(child: VelocityChart(task)),
                if (task.state != TaskState.LOW_START) ...[
                  const SizedBox(width: P),
                  Flexible(
                    child: Column(children: [
                      _textRow(loc.chart_velocity_project_label, '${(task.project!.velocity * daysPerMonth).round()}'),
                      if (task.requiredVelocity != null)
                        _textRow(loc.chart_velocity_target_label, '${(task.requiredVelocity! * daysPerMonth).round()}'),
                    ]),
                  ),
                ],
              ]),
            ],

            /// срок
            if (task.canShowTimeChart) ...[
              H3(loc.chart_timing_title),
              const SizedBox(height: P),
              TimingChart(task),
              const SizedBox(height: P_2),
              if (!task.isFuture) _textRow(loc.chart_timing_elapsed_label, '${loc.days_count(task.elapsedPeriod?.inDays ?? 0)}'),
              if (task.leftPeriod != null)
                _textRow(
                  _timeDelta >= 0 ? loc.chart_timing_left_label : loc.state_overdue_title,
                  '${loc.days_count(_timeDelta.abs())}',
                  color: _timeDelta > 0 ? null : warningColor,
                ),
              if (task.etaPeriod != null) _textRow(loc.chart_timing_eta_label, '${loc.days_count(task.etaPeriod!.inDays)}'),
              if (task.riskPeriod != null) H3(task.stateTitle, padding: const EdgeInsets.only(top: P_2)),
            ],
          ],
        ),
      ),
    );
  }
}
