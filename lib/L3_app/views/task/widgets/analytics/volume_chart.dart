// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/pie_chart.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/number.dart';

class TaskVolumeChart extends StatelessWidget {
  const TaskVolumeChart(this.task);
  final Task task;

  static const _R = P12;

  static const _maxValue = 1.0;
  static const _gaugeWidth = P2;
  static const _barWidth = _gaugeWidth;

  Color get _barColor => mainColor.withAlpha(120);

  MTPieChartData get _gaugeBar => MTPieChartData(_maxValue, strokeWidth: _gaugeWidth);
  MTPieChartData get _mainBar => MTPieChartData(task.progress, start: 0, color: _barColor, strokeWidth: _barWidth);

  String get _chartText => '${task.progress.percents}';

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(radius: _R, data: [MTPieChartData(1)]),
        MTPieChart(
          radius: _R,
          totalValue: 1,
          data: [_gaugeBar, _mainBar],
        ),
        D2(_chartText, color: mainColor),
        D5(loc.chart_volume_title.toLowerCase(), padding: const EdgeInsets.only(top: _R / 2 + P4), color: f2Color),
      ],
    );
  }
}
