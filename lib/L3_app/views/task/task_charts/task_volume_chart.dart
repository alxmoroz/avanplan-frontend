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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(onePadding / 2),
      child: PieChart(
        dataMap: {loc.task_state_closed: task.closedLeafTasksCount.toDouble()},
        totalValue: task.leafTasksCount.toDouble(),
        chartRadius: onePadding * 9,
        chartType: ChartType.ring,
        ringStrokeWidth: onePadding,
        centerText: '${loc.task_state_closed}\n${task.closedLeafTasksCount} ${loc.count_of} ${task.leafTasksCount}',
        centerTextStyle: const SmallText('').style(context),
        chartValuesOptions: const ChartValuesOptions(
          showChartValueBackground: false,
          showChartValuesOutside: true,
          showChartValuesInPercentage: true,
          decimalPlaces: 0,
        ),
        degreeOptions: const DegreeOptions(initialAngle: -90),
        legendOptions: const LegendOptions(showLegends: false),
        colorList: [bgGreenColor.resolve(context)],
        baseChartColor: darkBackgroundColor.resolve(context),
      ),
    );
  }
}
