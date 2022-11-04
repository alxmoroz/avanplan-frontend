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
import '../../../presenters/date_presenter.dart';

class TaskSpeedChart extends StatelessWidget {
  const TaskSpeedChart(this.task);
  final Task task;

  static const _bottomGaugeAngle = 90.0;
  static const _startAngle = 90 + _bottomGaugeAngle / 2;
  static const _sweepAngle = 360 - _bottomGaugeAngle;

  double get _gaugeWidth => onePadding * 1.5;
  double get _barWidth => _gaugeWidth / 2;
  double get _radius => onePadding * 6.5;
  double get _factSpeed => task.projectOrWSSpeed;
  double get _delta => (task.targetSpeed ?? _factSpeed) - _factSpeed;
  double get _firstValue => _delta >= 0 ? _factSpeed : _factSpeed + _delta;
  double get _maxValue => max(_factSpeed, task.targetSpeed ?? 1 / secondsInMonth) * 1.3;
  double get _degreeValue => _maxValue / _sweepAngle;

  String get _factSpeedText => '${(_factSpeed * secondsInMonth).round()}';

  Color get _pointerColor => _delta == 0
      ? darkGreyColor
      : _delta > 0
          ? warningColor
          : greenColor;

  Color get _barColor => lightGreyColor;

  MTPieChartData get _gaugeBar => MTPieChartData(_maxValue, strokeWidth: _gaugeWidth);
  MTPieChartData get _mainBar => MTPieChartData(_firstValue, start: 0, color: _barColor, strokeWidth: _barWidth);
  MTPieChartData get _deltaBar => MTPieChartData(_delta.abs(), color: _barColor, strokeWidth: _barWidth);

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
        strokeWidth: _delta > 0 ? _gaugeWidth : _barWidth,
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
            if (_delta < 0) _deltaBar,
            if (_delta != 0) _deltaPointer,
            _mainPointer,
          ],
        ),
        D1('$_factSpeedText', color: _pointerColor, padding: EdgeInsets.only(bottom: onePadding / 2)),
        SmallText(loc.task_charts_speed_unit_t_mo, padding: EdgeInsets.only(top: _radius / 2 + onePadding / 2), color: lightGreyColor),
        Container(
          width: _radius * 2 - onePadding * 5,
          height: _radius * 2 - onePadding * 4,
          alignment: Alignment.bottomCenter,
          child: Row(children: [
            if (_maxValue > 0) const MediumText('0', color: darkGreyColor),
            const Spacer(),
            if (_maxValue > 0) MediumText('${(_maxValue * secondsInMonth).round()}', color: darkGreyColor),
          ]),
        ),
      ],
    );
  }
}
