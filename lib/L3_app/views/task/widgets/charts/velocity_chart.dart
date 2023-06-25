// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_pie_chart.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/duration_presenter.dart';

class VelocityChart extends StatelessWidget {
  const VelocityChart(this.task);
  final Task task;

  static const _bottomGaugeAngle = 90.0;
  static const _startAngle = 90 + _bottomGaugeAngle / 2;
  static const _sweepAngle = 360 - _bottomGaugeAngle;

  double get _gaugeWidth => P * 1.5;
  double get _barWidth => _gaugeWidth / 2;
  double get _radius => P * 6.5;
  double get _velocity => task.projectVelocity ?? 0;
  double get _delta => (task.targetVelocity ?? _velocity) - _velocity;
  double get _firstValue => _delta >= 0 ? _velocity : _velocity + _delta;
  double get _maxValue => max(_velocity, task.targetVelocity ?? 1 / daysPerMonth) * 1.3;
  double get _degreeValue => _maxValue / _sweepAngle;

  String get _displayText => '${(_velocity * daysPerMonth).round()}';

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
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(
          radius: _radius,
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
          D3('$_displayText', color: _pointerColor, padding: const EdgeInsets.only(bottom: P_2)),
          SmallText(task.showSP ? loc.chart_velocity_unit_sp_mo : loc.chart_velocity_unit_t_mo,
              padding: EdgeInsets.only(top: _radius / 2 + P_2), color: lightGreyColor),
          Container(
            width: _radius * 2 - P * 5,
            height: _radius * 2 - P * 4,
            alignment: Alignment.bottomCenter,
            child: Row(children: [
              if (_maxValue > 0) const MediumText('0', color: greyColor),
              const Spacer(),
              if (_maxValue > 0) MediumText('${(_maxValue * daysPerMonth).round()}', color: greyColor),
            ]),
          ),
        ],
        if (task.projectLowStart)
          H3(
            loc.state_low_start_before_calc_duration(task.projectStartEtaCalcPeriod!.localizedString),
            align: TextAlign.center,
            maxLines: 5,
          )
      ],
    );
  }
}
