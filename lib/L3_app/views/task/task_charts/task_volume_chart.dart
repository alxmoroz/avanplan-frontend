// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/number_presenter.dart';

class TaskVolumeChart extends StatelessWidget {
  const TaskVolumeChart(this.task);
  final Task task;

  double get _factValue => task.closedLeafTasksCount.toDouble();
  double get _delta => (task.planVolume ?? _factValue) - _factValue;
  double get _firstValue => _delta >= 0 ? _factValue : _factValue - _delta;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(onePadding / 2),
      child: PieChart(
        dataMap: {'f': _firstValue, 'd': _delta},
        totalValue: task.leafTasksCount.toDouble(),
        chartRadius: onePadding * 12,
        ringStrokeWidth: onePadding,
        centerText: '${(_factValue / task.leafTasksCount).inPercents}',
        centerTextStyle: const LightText('', sizeScale: 2.5).style(context),
        chartValuesOptions: const ChartValuesOptions(showChartValues: false, showChartValueBackground: false),
        degreeOptions: const DegreeOptions(initialAngle: -90),
        legendOptions: const LegendOptions(showLegends: false),
        colorList: [(_delta >= 0 ? lightWarningColor : lightGreenColor).resolve(context), darkBackgroundColor.resolve(context)],
        baseChartColor: darkBackgroundColor.resolve(context),
      ),
    );
  }
}
