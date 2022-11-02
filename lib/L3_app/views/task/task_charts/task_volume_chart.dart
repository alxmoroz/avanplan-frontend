// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_pie_chart.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/number_presenter.dart';

class TaskVolumeChart extends StatelessWidget {
  const TaskVolumeChart(this.task);
  final Task task;

  double get _radius => onePadding * 6.5;
  double get _factValue => task.closedLeafTasksCount.toDouble();
  double get _delta => (task.planVolume ?? _factValue) - _factValue;
  double get _firstValue => _delta >= 0 ? _factValue : _factValue + _delta;
  double get _maxValue => (task.leafTasksCount > 0 ? task.leafTasksCount : 1).toDouble();
  double get _degreeValue => _maxValue / 360;

  double get _gaugeWidth => onePadding * 1.5;
  double get _barWidth => _gaugeWidth / 2;

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

  MTPieChartData get _gaugeBar => MTPieChartData(_maxValue, strokeWidth: _gaugeWidth);
  MTPieChartData get _mainBar => MTPieChartData(_firstValue, start: 0, color: _barColor, strokeWidth: _barWidth);
  MTPieChartData get _deltaBar => MTPieChartData(_delta.abs(), color: _barColor, strokeWidth: _delta > 0 ? onePadding / 6 : _barWidth);

  double get _deltaPointerWidthValue => _degreeValue * 2;
  double get _deltaPointerStartValue => _firstValue + (_delta > 0 ? _delta : 0) - _deltaPointerWidthValue / 2;

  MTPieChartData get _deltaPointer => MTPieChartData(_deltaPointerWidthValue,
      start: _deltaPointerStartValue, color: _pointerColor, strokeWidth: _delta > 0 ? _gaugeWidth : _barWidth);

  String get _chartText => '${(_factValue / (task.leafTasksCount > 0 ? task.leafTasksCount : 1)).inPercents}';
  // String get _chartText => '100%';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(radius: _radius, data: [MTPieChartData(_maxValue)]),
        MTPieChart(
          radius: _radius,
          totalValue: _maxValue,
          data: [
            _gaugeBar,
            _mainBar,
            if (_delta != 0) _deltaBar,
            if (_delta != 0) _deltaPointer,
          ],
        ),
        D1(_chartText, color: _pointerColor, padding: EdgeInsets.only(bottom: onePadding / 2)),
        SmallText(loc.task_volume_unit, padding: EdgeInsets.only(top: _radius / 2 + onePadding / 2), color: lightGreyColor),
      ],
    );
  }
}
