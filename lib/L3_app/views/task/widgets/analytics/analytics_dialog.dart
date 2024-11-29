// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../../L1_domain/entities_extensions/task_state.dart';
import '../../../../../L1_domain/utils/dates.dart';
import '../../../../components/card.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/workspace.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/state.dart';
import 'timing_chart.dart';
import 'velocity_chart.dart';
import 'volume_chart.dart';

Future analyticsDialog(TaskController tc) async => await showMTDialog(_AnalyticsDialog(tc));

class _AnalyticsDialog extends StatelessWidget {
  const _AnalyticsDialog(this._tc);
  final TaskController _tc;

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

  num _hVelocity(Task t) => (t.project.velocity * DAYS_IN_MONTH).round();
  String _velocityUnit(Task t) => loc.chart_velocity_unit_mo(t.ws.estimateUnitCode);

  Widget _chartCard(Widget child) => Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: MTCard(elevation: 0, padding: const EdgeInsets.all(P2), child: child),
      );

  Widget _totalVolumeDetails(Task t) {
    final totalVolume = t.totalVolume.round();
    final closedVolume = (t.closedVolume ?? 0).round();
    return _details(
      loc.state_closed,
      '$closedVolume / $totalVolume',
      unit: t.ws.estimateUnitCode,
      divider: false,
    );
  }

  Widget _leftPeriodDetails(Task t) {
    int timeDelta = t.leftPeriod!.inDays;
    return _details(
      timeDelta >= 0 ? loc.chart_timing_left_label : loc.state_overdue_title,
      loc.days_count(timeDelta.abs()),
      color: timeDelta > 0 ? null : warningColor,
      divider: t.etaPeriod != null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    return MTDialog(
      topBar: MTTopBar(pageTitle: loc.analytics_title, parentPageTitle: t.title),
      body: ListView(
        shrinkWrap: true,
        children: [
          H2(_tc.overallStateTitle, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3, vertical: P3)),
          if (t.canShowVelocityVolumeCharts) ...[
            /// объем
            _chartCard(TaskVolumeChart(t)),
            const SizedBox(height: P3),
            _totalVolumeDetails(t),

            /// скорость
            const SizedBox(height: P6),
            _chartCard(VelocityChart(t)),
            if (t.state != TaskState.LOW_START) ...[
              const SizedBox(height: P3),
              _details(
                loc.chart_velocity_project_label,
                '${_hVelocity(t)}',
                unit: _velocityUnit(t),
                divider: t.requiredVelocity != null,
              ),
              if (t.requiredVelocity != null)
                _details(
                  loc.chart_velocity_required_label,
                  '${(t.requiredVelocity! * DAYS_IN_MONTH).round()}',
                  unit: _velocityUnit(t),
                  divider: false,
                ),
            ],
          ],

          /// срок, время
          if (t.canShowTimeChart) ...[
            const SizedBox(height: P6),
            _chartCard(TimingChart(_tc)),
            const SizedBox(height: P3),
            if (!t.isFuture)
              _details(
                loc.chart_timing_elapsed_label,
                loc.days_count(t.elapsedPeriod?.inDays ?? 0),
                divider: t.leftPeriod != null || t.etaPeriod != null,
              ),
            if (t.leftPeriod != null) _leftPeriodDetails(t),
            if (t.etaPeriod != null)
              _details(
                loc.chart_timing_eta_title,
                loc.days_count(t.etaPeriod!.inDays),
                divider: false,
              ),
          ],
        ],
      ),
    );
  }
}
