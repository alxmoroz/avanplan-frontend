// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_pie_chart.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';

class TaskSpeedChart extends StatelessWidget {
  const TaskSpeedChart(this.task);
  final Task task;

  static const _secondsInMonth = 3600 * 24 * 30.4;
  static const _bottomGaugeAngle = 100.0;
  static const _startAngle = 90 + _bottomGaugeAngle / 2;
  static const _sweepAngle = 360 - _bottomGaugeAngle;

  double get _gaugeWidth => onePadding * 1.5;
  double get _barWidth => _gaugeWidth / 2;
  double get _radius => onePadding * 6.5;
  double get _factSpeed => task.factSpeed;
  double get _delta => (task.targetSpeed ?? _factSpeed) - _factSpeed;
  double get _firstValue => _delta >= 0 ? _factSpeed : _factSpeed + _delta;
  double get _maxValue => max(_factSpeed, _factSpeed + _delta) * 1.3;
  double get _degreeValue => _maxValue / _sweepAngle;

  String get _factSpeedText => '${(_factSpeed * _secondsInMonth).round()}';
  // String get _factSpeedText => '666';

  Color get _pointerColor => _delta == 0
      ? darkGreyColor
      : _delta > 0
          ? warningColor
          : greenColor;
  Color get _barColor => _delta == 0
      ? lightGreyColor
      : _delta > 0
          ? lightWarningColor
          : lightGreenColor;

  MTPieChartData get _mainBar => MTPieChartData(_firstValue, color: _barColor, strokeWidth: _barWidth);
  MTPieChartData get _mainPointer => MTPieChartData(_degreeValue * 4, color: _pointerColor, strokeWidth: _gaugeWidth * 1.8);
  MTPieChartData get _deltaBar => MTPieChartData(_delta.abs(), color: _barColor, strokeWidth: _delta > 0 ? onePadding / 6 : _barWidth);
  MTPieChartData get _deltaPointer => MTPieChartData(_degreeValue * 2, color: _delta > 0 ? lightWarningColor : greenColor, strokeWidth: _gaugeWidth);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(
          radius: _radius,
          startAngle: _startAngle,
          sweepAngle: _sweepAngle,
          data: [MTPieChartData(_maxValue, strokeWidth: _gaugeWidth)],
        ),
        MTPieChart(
          radius: _radius,
          startAngle: _startAngle,
          sweepAngle: _sweepAngle,
          totalValue: _maxValue,
          data: [
            _mainBar,
            _delta >= 0 ? _mainPointer : _deltaPointer,
            if (_delta != 0) ...[
              _deltaBar,
              _delta > 0 ? _deltaPointer : _mainPointer,
            ],
          ],
        ),
        BaseText('$_factSpeedText', sizeScale: 3, color: _pointerColor, weight: FontWeight.w500),
        SmallText(loc.task_speed_unit_t_mo, padding: EdgeInsets.only(top: _radius * 1.5), color: lightGreyColor),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: onePadding * 3.3).copyWith(top: onePadding * 6.2),
            child: Row(children: [
              if (_maxValue > 0) const MediumText('0', color: darkGreyColor),
              const Spacer(),
              if (_maxValue > 0) MediumText('${(_maxValue * _secondsInMonth).round()}', color: darkGreyColor),
            ])),
      ],
    );
  }
}
