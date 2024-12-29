// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities_extensions/task_dates.dart';
import '../../../../../L1_domain/entities_extensions/task_state.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/progress.dart';
import '../../../../components/text.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/task_state.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/state.dart';

class _DateBarData {
  _DateBarData({required this.date, this.color, this.mark});
  final DateTime date;
  final Color? color;
  final MTProgressMark? mark;
}

class TimingChart extends StatelessWidget {
  const TimingChart(this._tc, {super.key, this.showDueLabel = true});
  final TaskController _tc;
  final bool showDueLabel;

  static const _barHeight = P4;
  static const _borderWidth = P;
  static const _borderR = _barHeight / 2;
  static const _markSize = Size(P2, P2);
  static const _barColor = mainColor;

  Color get _etaMarkColor => stateColor(_tc.overallState, defaultColor: mainColor);

  Iterable<_DateBarData> get _dateBarData {
    final t = _tc.task;
    final now = DateTime.now();
    final res = <_DateBarData>[
      /// старт
      _DateBarData(date: t.calculatedStartDate),

      /// сегодня
      if (!t.isFuture) _DateBarData(date: now, color: t.hasOverdue ? _etaMarkColor : _barColor),

      /// срок
      if (t.hasDueDate)
        _DateBarData(
          date: t.dueDate!,
          color: t.dueDate!.isBefore(now) ? _barColor : null,
          mark: showDueLabel
              ? MTProgressMark(
                  const CaretIcon(size: _markSize),
                  size: Size(_markSize.width, -_markSize.height),
                )
              : null,
        ),

      /// прогноз
      if (t.hasEtaDate)
        _DateBarData(
          date: t.etaDate!,
          mark: MTProgressMark(
            CaretIcon(color: _etaMarkColor, size: _markSize, up: true),
            size: Size(_markSize.width, _barHeight),
          ),
        ),
    ];

    res.sort((a, b) => a.date.compareTo(b.date));
    return res.reversed;
  }

  double _dateRatio(DateTime dt) {
    final sortedDates = _dateBarData.map((dbd) => dbd.date);
    final maxDate = sortedDates.first;
    final minDate = sortedDates.last;
    final maxDateDays = maxDate.difference(minDate).inDays;
    final passDays = dt.difference(minDate).inDays;

    return maxDateDays > 0 ? ((passDays > 0 ? passDays : 1) / maxDateDays) : 1;
  }

  Widget _bg(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_borderR),
        gradient: LinearGradient(
          colors: [b1Color.resolve(context), b2Color.resolve(context)],
          stops: const [0, 0.42],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      height: _barHeight,
    );
  }

  Widget _progress(BuildContext context) {
    return SizedBox(
      height: _barHeight - _borderWidth * 2,
      child: Row(
        children: [
          const SizedBox(width: _borderR / 2),
          Expanded(
            child: Stack(
              children: [
                ..._dateBarData.map((dbd) {
                  final ratio = _dateRatio(dbd.date);
                  return ratio > 0
                      ? MTProgress(
                          ratio,
                          color: dbd.color,
                          mark: dbd.mark,
                          borderWidth: _borderWidth,
                        )
                      : const SizedBox();
                })
              ],
            ),
          ),
          const SizedBox(width: _borderR / 2),
        ],
      ),
    );
  }

  Widget _timeChart(BuildContext context) {
    return SizedBox(
      height: _barHeight,
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          _bg(context),
          _progress(context),
        ],
      ),
    );
  }

  Widget _dateLabel(BuildContext context, {required DateTime date, required String label, Color? color}) {
    return Row(
      children: [
        DSmallText(label.toLowerCase(), color: color),
        const Spacer(),
        DSmallText(date.strMedium, color: color),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    return Column(children: [
      if (t.hasDueDate && showDueLabel) ...[
        _dateLabel(context, date: t.dueDate!, label: loc.task_due_date_label, color: f2Color),
        SizedBox(height: _markSize.height + P_2),
      ],
      _timeChart(context),
      if (t.hasEtaDate) ...[
        SizedBox(height: _markSize.height + P_2),
        _dateLabel(context, date: t.etaDate!, label: loc.task_eta_date_label, color: _etaMarkColor),
      ]
    ]);
  }
}
