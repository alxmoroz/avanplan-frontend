// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../components/card.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_type.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/workspace.dart';
import '../../../../usecases/project_features.dart';
import '../../../../usecases/task_tree.dart';
import 'timing_chart.dart';
import 'velocity_chart.dart';
import 'volume_chart.dart';

Future analyticsDialog(Task task) async => await showMTDialog<void>(_AnalyticsDialog(task));

class _AnalyticsDialog extends StatelessWidget {
  const _AnalyticsDialog(this._task);
  final Task _task;

  Widget _details(String t1, String t2, {String? unit, Color? color, bool divider = true}) => MTListTile(
        middle: BaseText.f3(t1, maxLines: 1),
        subtitle: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            H3(t2, color: color, maxLines: 1, height: 1),
            if (unit != null) BaseText(' $unit', maxLines: 1, color: f2Color, height: 1.1),
          ],
        ),
        bottomDivider: divider,
      );

  int get _timeDelta => _task.leftPeriod!.inDays;
  num get _hVelocity => (_task.project.velocity * DAYS_IN_MONTH).round();
  num get _closedVolume => (_task.closedVolume ?? 0).round();
  num get _totalVolume => _task.totalVolume.round();
  String get _velocityUnit => loc.chart_velocity_unit_mo(_task.hfEstimates ? _task.ws.estimateUnitCode : loc.task_plural(_hVelocity));

  Widget _chartCard(Widget child) => Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: MTCard(elevation: 0, padding: const EdgeInsets.all(P2), child: child),
      );

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      topBar: MTAppBar(showCloseButton: true, color: b2Color, middle: _task.subPageTitle(loc.analytics_title)),
      body: ListView(
        shrinkWrap: true,
        children: [
          H2(_task.overallStateTitle, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3, vertical: P3)),
          if (_task.canShowVelocityVolumeCharts) ...[
            /// объем
            _chartCard(TaskVolumeChart(_task)),
            const SizedBox(height: P3),
            _details(
              loc.state_closed,
              '$_closedVolume / $_totalVolume',
              unit: _task.hfEstimates ? _task.ws.estimateUnitCode : loc.task_plural(_totalVolume),
              divider: false,
            ),
            // _details(loc.state_opened, '${(task.openedVolume ?? 0).round()}', divider: false),

            /// скорость
            const SizedBox(height: P6),
            _chartCard(VelocityChart(_task)),
            if (_task.state != TaskState.LOW_START) ...[
              const SizedBox(height: P3),
              _details(
                loc.chart_velocity_project_label,
                '$_hVelocity',
                unit: _velocityUnit,
                divider: _task.requiredVelocity != null,
              ),
              if (_task.requiredVelocity != null)
                _details(
                  loc.chart_velocity_required_label,
                  '${(_task.requiredVelocity! * DAYS_IN_MONTH).round()}',
                  unit: _velocityUnit,
                  divider: false,
                ),
            ],
          ],

          /// срок, время
          if (_task.canShowTimeChart) ...[
            const SizedBox(height: P6),
            _chartCard(TimingChart(_task)),
            const SizedBox(height: P3),
            if (!_task.isFuture)
              _details(
                loc.chart_timing_elapsed_label,
                loc.days_count(_task.elapsedPeriod?.inDays ?? 0),
                divider: _task.leftPeriod != null || _task.etaPeriod != null,
              ),
            if (_task.leftPeriod != null)
              _details(
                _timeDelta >= 0 ? loc.chart_timing_left_label : loc.state_overdue_title,
                loc.days_count(_timeDelta.abs()),
                color: _timeDelta > 0 ? null : warningColor,
                divider: _task.etaPeriod != null,
              ),
            if (_task.etaPeriod != null)
              _details(
                loc.chart_timing_eta_title,
                loc.days_count(_task.etaPeriod!.inDays),
                divider: false,
              ),
          ],
        ],
      ),
    );
  }
}
