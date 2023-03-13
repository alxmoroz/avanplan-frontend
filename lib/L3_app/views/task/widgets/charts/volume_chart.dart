// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/mt_pie_chart.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number_presenter.dart';

class TaskVolumeChart extends StatelessWidget {
  const TaskVolumeChart(this.task);
  final Task task;

  double get _radius => P * 6.5;
  double get _factValue => task.closedLeafTasksCount.toDouble();
  double get _delta => (task.planVolume ?? _factValue) - _factValue;
  double get _firstValue => _delta >= 0 ? _factValue : _factValue + _delta;
  double get _maxValue => (task.leafTasksCount > 0 ? task.leafTasksCount : 1).toDouble();
  double get _degreeValue => _maxValue / 360;

  double get _gaugeWidth => P * 1.5;
  double get _barWidth => _gaugeWidth;

  Color get _pointerColor => _delta == 0
      ? greyColor
      : _delta > 0
          ? warningColor
          : greenColor;

  Color get _barColor => lightGreyColor;
  Color get _deltaBarColor => _delta > 0 ? lightWarningColor : _barColor;

  MTPieChartData get _gaugeBar => MTPieChartData(_maxValue, strokeWidth: _gaugeWidth);
  MTPieChartData get _mainBar => MTPieChartData(_firstValue, start: 0, color: _barColor, strokeWidth: _barWidth);
  MTPieChartData get _deltaBar => MTPieChartData(_delta.abs(), color: _deltaBarColor, strokeWidth: _barWidth);

  double get _deltaPointerWidthValue => _degreeValue * 2;
  double get _deltaPointerStartValue => _firstValue + (_delta > 0 ? _delta : 0) - _deltaPointerWidthValue / 2;

  MTPieChartData get _deltaPointer =>
      MTPieChartData(_deltaPointerWidthValue, start: _deltaPointerStartValue, color: _pointerColor, strokeWidth: _barWidth);

  String get _chartText => '${(_factValue / (task.leafTasksCount > 0 ? task.leafTasksCount : 1)).percents}';

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
        D1(_chartText, color: _pointerColor, padding: const EdgeInsets.only(bottom: P_2)),
        SmallText(loc.chart_volume_unit, padding: EdgeInsets.only(top: _radius / 2 + P_2), color: lightGreyColor),
      ],
    );
  }
}
