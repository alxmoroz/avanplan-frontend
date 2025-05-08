// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/pie_chart.dart';
import '../../../../presenters/number.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../app/services.dart';

class TaskVolumeChart extends StatelessWidget {
  const TaskVolumeChart(this._task, {super.key});
  final Task _task;

  static const _R = P12;

  static const _maxValue = 1.0;
  static const _bgWidth = P3;
  static const _borderWidth = P_2;
  static const _barWidth = _bgWidth - _borderWidth * 2;

  MTPieChartData get _bgBar => const MTPieChartData(_maxValue, strokeWidth: _bgWidth);
  MTPieChartData get _mainBar => MTPieChartData(_task.progress, start: 0, color: mainColor, strokeWidth: _barWidth);

  String get _chartText => _task.progress.percents;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        MTPieChart(radius: _R, data: [_bgBar]),
        MTPieChart(
          radius: _R - _borderWidth,
          totalValue: 1,
          data: [_mainBar],
        ),
        D2(_chartText),
        DSmallText(loc.chart_volume_title.toLowerCase(), padding: const EdgeInsets.only(top: _R / 2 + P4), color: f2Color),
      ],
    );
  }
}
