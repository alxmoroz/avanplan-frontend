// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/pie_chart.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/duration.dart';
import '../../../../presenters/task_state.dart';
import '../../../../usecases/task_stats.dart';

class VelocityChart extends StatelessWidget {
  const VelocityChart(this._task, {super.key});
  final Task _task;
  static const _R = P12;

  static const _bottomGaugeAngle = 106;
  static const _startAngle = 90.0 + _bottomGaugeAngle / 2;
  static const _sweepAngle = 360.0 - _bottomGaugeAngle;
  static const _bgWidth = P3;
  static const _borderWidth = P_2;
  static const _barWidth = _bgWidth - _borderWidth * 2;

  double get _velocity => _task.projectVelocity ?? 0;
  double get _maxValue => max(_velocity, _task.requiredVelocity ?? 1 / daysPerMonth) * 1.05;

  num get _hVelocity => (_velocity * daysPerMonth).round();
  String get _displayText => '$_hVelocity';

  MTPieChartData get _bgBar => MTPieChartData(_maxValue, strokeWidth: _bgWidth);
  MTPieChartData get _valueBar => MTPieChartData(_velocity, start: 0, color: mainColor, strokeWidth: _barWidth);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(
          radius: _R,
          startAngle: _startAngle,
          sweepAngle: _sweepAngle,
          totalValue: _maxValue,
          data: [_bgBar],
        ),
        MTPieChart(
          radius: _R - _borderWidth,
          startAngle: _startAngle,
          sweepAngle: _sweepAngle,
          totalValue: _maxValue,
          data: [_valueBar],
        ),
        if (!_task.projectLowStart) ...[
          D2(_displayText),
          D5(
            loc.chart_velocity_title.toLowerCase(),
            padding: const EdgeInsets.only(top: _R / 2 + P4),
            color: f2Color,
          ),
        ] else
          H3(
            loc.state_low_start_before_calc_duration(_task.projectStartEtaCalcPeriod!.localizedString),
            align: TextAlign.center,
            color: f2Color,
            maxLines: 2,
          )
      ],
    );
  }
}
