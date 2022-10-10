// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:gercules/L3_app/components/mt_pie_chart.dart';
import 'package:gercules/L3_app/presenters/number_presenter.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';

class TaskVolumeChart extends StatelessWidget {
  const TaskVolumeChart(this.task);
  final Task task;

  double get _radius => onePadding * 6.5;
  double get _factValue => task.closedLeafTasksCount.toDouble();
  double get _delta => (task.planVolume ?? _factValue) - _factValue;
  double get _firstValue => _delta >= 0 ? _factValue : _factValue + _delta;
  double get _maxValue => task.leafTasksCount.toDouble();
  double get _degreeValue => _maxValue / 360;

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

  MTPieChartData get _mainBar => MTPieChartData(_firstValue, color: _barColor);
  MTPieChartData get _deltaBar => MTPieChartData(_delta.abs(), color: _barColor, strokeWidth: _delta > 0 ? onePadding / 6 : _radius);
  MTPieChartData get _deltaPointer => MTPieChartData(_degreeValue * 2, color: lightWarningColor, strokeWidth: onePadding);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(radius: _radius, data: [MTPieChartData(_maxValue)]),
        MTPieChart(
          radius: _radius,
          strokeWidth: _radius,
          totalValue: _maxValue,
          data: [
            _mainBar,
            if (_delta != 0) _deltaBar,
            if (_delta > 0) _deltaPointer,
          ],
        ),
        BaseText('${(_factValue / task.leafTasksCount).inPercents}', sizeScale: 3, color: _pointerColor, weight: FontWeight.w500),
      ],
    );
  }
}
