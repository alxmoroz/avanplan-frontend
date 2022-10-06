// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';

class TaskSpeedChart extends StatelessWidget {
  const TaskSpeedChart(this.task);
  final Task task;

  static const _secondsInMonth = 3600 * 24 * 30.4;

  double get _factSpeed => task.factSpeed;

  double get _delta => (task.targetSpeed ?? _factSpeed) - _factSpeed;
  double get _firstValue => _delta >= 0 ? _factSpeed : _factSpeed - _delta;
  double get _maxValue => max(_factSpeed, _factSpeed + _delta) * 1.3;
  double get _tickValue => 2 * _maxValue / (360 - _bottomGaugeAngle);

  static const _bottomGaugeAngle = 120.0;

  String get _factSpeedText => '${(_factSpeed * _secondsInMonth).round()}';
  String get _targetSpeedText => _delta != 0 ? ' ${loc.count_of} ${(_factSpeed + _delta * _secondsInMonth).round()}' : '';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.all(onePadding / 2),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                PieChart(
                  dataMap: {'f': _firstValue, 'd': _delta - _tickValue, 't': _tickValue, 'e': _maxValue - (_firstValue + _delta)},
                  totalValue: _maxValue,
                  chartRadius: onePadding * 11,
                  chartType: ChartType.ring,
                  ringStrokeWidth: onePadding,
                  chartValuesOptions: const ChartValuesOptions(showChartValueBackground: false, showChartValues: false),
                  degreeOptions: const DegreeOptions(initialAngle: 90 + _bottomGaugeAngle / 2, totalDegrees: 360 - _bottomGaugeAngle),
                  legendOptions: const LegendOptions(showLegends: false),
                  colorList: [
                    (_delta != 0 ? bgGreenColor : borderColor).resolve(context),
                    (_delta > 0 ? lightWarningColor : greenColor).resolve(context),
                    (_delta > 0 ? dangerColor : darkBackgroundColor).resolve(context),
                    darkBackgroundColor.resolve(context),
                  ],
                ),
                Column(
                  children: [
                    H2('$_factSpeedText$_targetSpeedText'),
                    SmallText(loc.task_speed_unit_t_mo),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
