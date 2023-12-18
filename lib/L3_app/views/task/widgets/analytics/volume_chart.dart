// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
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

  double get _maxValue => 1;
  double get _gaugeWidth => P3;
  double get _barWidth => _gaugeWidth;

  Color get _pointerColor => mainColor;

  Color get _barColor => _pointerColor.withAlpha(120);

  MTPieChartData get _gaugeBar => MTPieChartData(_maxValue, strokeWidth: _gaugeWidth);
  MTPieChartData get _mainBar => MTPieChartData(task.progress, start: 0, color: _barColor, strokeWidth: _barWidth);

  String get _chartText => '${task.progress.percents}';

  @override
  Widget build(BuildContext context) {
    final R = P * (isBigScreen(context) ? 14 : 12.5);
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(radius: R, data: [MTPieChartData(1)]),
        MTPieChart(
          radius: R,
          totalValue: 1,
          data: [
            _gaugeBar,
            _mainBar,
          ],
        ),
        D2(_chartText, color: _pointerColor),
        SmallText(loc.chart_volume_unit, padding: EdgeInsets.only(top: R / 2 + P3), color: f2Color),
      ],
    );
  }
}
