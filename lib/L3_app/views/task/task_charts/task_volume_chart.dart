// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:pie_chart/pie_chart.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';

class TaskVolumeChart extends StatelessWidget {
  const TaskVolumeChart(this.task);
  final Task task;

  double get _factValue => task.closedLeafTasksCount.toDouble();
  double get _delta => (task.planVolume ?? _factValue) - _factValue;
  double get _firstValue => _delta >= 0 ? _factValue : _factValue - _delta;

  String get _factVolumeText => '${loc.task_state_closed}\n${task.closedLeafTasksCount} ${loc.count_of} ${task.leafTasksCount}';
  String get _planVolumeText => _delta > 0 ? '\n\n${loc.goal_title}\n${task.planVolume?.round()} ${loc.count_of} ${task.leafTasksCount}' : '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(onePadding / 2),
      child: PieChart(
        dataMap: {'f': _firstValue, 'd': _delta},
        totalValue: task.leafTasksCount.toDouble(),
        chartRadius: onePadding * 11,
        chartType: ChartType.ring,
        ringStrokeWidth: onePadding,
        centerText: '$_factVolumeText$_planVolumeText',
        centerTextStyle: const SmallText('').style(context),
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: false,
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          decimalPlaces: 0,
        ),
        degreeOptions: const DegreeOptions(initialAngle: -90),
        legendOptions: const LegendOptions(showLegends: false),
        colorList: [bgGreenColor.resolve(context), (_delta >= 0 ? lightWarningColor : greenColor).resolve(context)],
        baseChartColor: darkBackgroundColor.resolve(context),
      ),
    );
  }
}
