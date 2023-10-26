// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../../../../L1_domain/entities/task.dart';
import '../../../../../components/adaptive.dart';
import '../../../../../components/colors.dart';
import '../../../../../components/colors_base.dart';
import '../../../../../components/constants.dart';
import '../../../../../components/pie_chart.dart';
import '../../../../../components/text.dart';
import '../../../../../extra/services.dart';
import '../../../../../presenters/duration.dart';
import '../../../../../presenters/task_state.dart';
import '../../../../../presenters/task_stats.dart';
import '../../../../../presenters/workspace.dart';
import '../../../../../usecases/task_feature_sets.dart';

class VelocityChart extends StatelessWidget {
  const VelocityChart(this.task);
  final Task task;

  static const _bottomGaugeAngle = 90.0;
  static const _startAngle = 90 + _bottomGaugeAngle / 2;
  static const _sweepAngle = 360 - _bottomGaugeAngle;

  double get _gaugeWidth => P3;
  double get _barWidth => _gaugeWidth / 2;
  double get _velocity => task.projectVelocity ?? 0;
  double get _delta => (task.requiredVelocity ?? _velocity) - _velocity;
  double get _firstValue => _delta >= 0 ? _velocity : _velocity + _delta;
  double get _maxValue => max(_velocity, task.requiredVelocity ?? 1 / daysPerMonth) * 1.3;
  double get _degreeValue => _maxValue / _sweepAngle;

  num get _hVelocity => (_velocity * daysPerMonth).round();
  String get _displayText => '$_hVelocity';

  Color get _pointerColor => _delta == 0
      ? mainColor
      : _delta > 0
          ? warningColor
          : greenColor;

  Color get _barColor => _pointerColor.withAlpha(120);
  Color get _deltaBarColor => _delta > 0 ? warningColor.withAlpha(50) : _barColor;

  MTPieChartData get _gaugeBar => MTPieChartData(_maxValue, strokeWidth: _gaugeWidth);
  MTPieChartData get _mainBar => MTPieChartData(_firstValue, start: 0, color: _barColor, strokeWidth: _barWidth);
  MTPieChartData get _deltaBar => MTPieChartData(_delta.abs(), color: _deltaBarColor, strokeWidth: _barWidth);

  double get _mainPointerWidthValue => _degreeValue * 5;
  double get _mainPointerStartValue => _firstValue + (_delta < 0 ? -_delta : 0) - _mainPointerWidthValue / 2;
  MTPieChartData get _mainPointer =>
      MTPieChartData(_mainPointerWidthValue, start: _mainPointerStartValue, color: _pointerColor, strokeWidth: _gaugeWidth * 2.1);

  double get _deltaPointerWidthValue => _degreeValue * 2;
  double get _deltaPointerStartValue => _firstValue + (_delta > 0 ? _delta : 0) - _deltaPointerWidthValue / 2;
  MTPieChartData get _deltaPointer => MTPieChartData(
        _deltaPointerWidthValue,
        start: _deltaPointerStartValue,
        color: _pointerColor,
        strokeWidth: _barWidth,
      );

  @override
  Widget build(BuildContext context) {
    final R = P * (isBigScreen(context) ? 14 : 12.5);
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(
          radius: R,
          startAngle: _startAngle,
          sweepAngle: _sweepAngle,
          totalValue: _maxValue,
          data: [
            _gaugeBar,
            _mainBar,
            if (_delta != 0) _deltaBar,
            if (_delta != 0) _deltaPointer,
            if (!task.projectLowStart) _mainPointer,
          ],
        ),
        if (!task.projectLowStart) ...[
          D2('$_displayText', color: _pointerColor),
          SmallText(
            loc.chart_velocity_unit_mo(task.hfsEstimates ? task.ws.estimateUnitCode : loc.task_plural(_hVelocity)),
            padding: EdgeInsets.only(top: R / 2 + P3),
            color: f2Color,
            height: 1,
          ),
          Container(
            width: R * 2 - P10 - P,
            height: R * 2 - P6,
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              if (_maxValue > 0) const BaseText.medium('0', color: f2Color),
              const Spacer(),
              if (_maxValue > 0) BaseText.medium('${(_maxValue * daysPerMonth).round()}', color: f2Color),
            ]),
          ),
        ] else
          H3(
            loc.state_low_start_before_calc_duration(task.projectStartEtaCalcPeriod!.localizedString),
            align: TextAlign.center,
            maxLines: 5,
          )
      ],
    );
  }
}
