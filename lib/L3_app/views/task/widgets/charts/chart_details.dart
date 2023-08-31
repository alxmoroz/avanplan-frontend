// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/duration.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/workspace.dart';
import 'timing_chart.dart';
import 'velocity_chart.dart';
import 'volume_chart.dart';

Future showChartsDetailsDialog(Task task) async => await showMTDialog<void>(TaskChartDetails(task));

class TaskChartDetails extends StatelessWidget {
  const TaskChartDetails(this.task);
  @protected
  final Task task;

  Widget _textRow(String t1, String t2, {Color? color}) => Row(
        children: [
          Expanded(child: NormalText.f2(t1)),
          H3(t2, color: color, padding: const EdgeInsets.only(top: P)),
        ],
      );

  int get _timeDelta => task.leftPeriod!.inDays;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTTopBar(titleText: loc.chart_details_title),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        color: b3Color.resolve(context),
        child: ListView(
          shrinkWrap: true,
          children: [
            const SizedBox(height: P),
            if (task.canShowVelocityVolumeCharts) ...[
              /// объем
              H3('${loc.chart_volume_title}, ${task.ws.estimateUnitCode}', align: TextAlign.center),
              Row(
                children: [
                  Flexible(child: TaskVolumeChart(task)),
                  const SizedBox(width: P3),
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
              const SizedBox(height: P3),
              H3(loc.chart_velocity_title, align: TextAlign.center),
              Row(children: [
                Flexible(child: VelocityChart(task)),
                if (task.state != TaskState.LOW_START) ...[
                  const SizedBox(width: P3),
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

            /// срок, время
            if (task.canShowTimeChart) ...[
              H3(loc.chart_timing_title, align: TextAlign.center),
              const SizedBox(height: P3),
              TimingChart(task),
              const SizedBox(height: P2),
              if (!task.isFuture) _textRow(loc.chart_timing_elapsed_label, '${loc.days_count(task.elapsedPeriod?.inDays ?? 0)}'),
              if (task.leftPeriod != null)
                _textRow(
                  _timeDelta >= 0 ? loc.chart_timing_left_label : loc.state_overdue_title,
                  '${loc.days_count(_timeDelta.abs())}',
                  color: _timeDelta > 0 ? null : warningColor,
                ),
              if (task.etaPeriod != null) _textRow(loc.chart_timing_eta_label, '${loc.days_count(task.etaPeriod!.inDays)}'),
              if (task.riskPeriod != null) H3(task.stateTitle, padding: const EdgeInsets.only(top: P)),
            ],
          ],
        ),
      ),
    );
  }
}
