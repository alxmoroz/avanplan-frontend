// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_card.dart';
import '../../../../components/mt_circle.dart';
import '../../../../components/mt_progress.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date.dart';

class _DateBarData {
  _DateBarData({required this.date, this.color, this.mark});
  final DateTime date;
  final Color? color;
  final MTProgressMark? mark;
}

class TimingChart extends StatelessWidget {
  const TimingChart(this.task);
  @protected
  final Task task;

  static double get _barHeight => P2;
  double get _suffixWidth => _barHeight / 2;
  double get _borderWidth => 0.0;

  Color get _pointerColor => task.hasRisk
      ? warningColor
      : task.hasOverdue
          ? dangerColor
          : task.isOk
              ? greenColor
              : mainColor;

  Color get _barColor => _pointerColor.withAlpha(120);

  Color get _planMarkColor => task.hasOverdue ? dangerColor : fgL2Color;

  Color get _etaMarkColor => task.hasRisk
      ? warningColor
      : task.isOk
          ? greenColor
          : fgL3Color;

  Size get _markSize => const Size(P * 0.7, P * 0.9);

  Iterable<_DateBarData> get _dateBarData {
    final _now = DateTime.now();
    final res = <_DateBarData>[
      /// старт
      _DateBarData(date: task.calculatedStartDate),

      /// план
      if (task.hasDueDate)
        _DateBarData(
          date: task.dueDate!,
          mark: MTProgressMark(
            child: CaretIcon(color: _planMarkColor, size: _markSize),
            size: Size(_markSize.width, -_markSize.height),
            color: _planMarkColor,
          ),
        ),

      /// прогноз
      if (task.hasEtaDate)
        _DateBarData(
          date: task.etaDate!,
          mark: MTProgressMark(
            child: CaretIcon(color: _etaMarkColor, size: _markSize, up: true),
            size: Size(_markSize.width, _barHeight),
            color: _etaMarkColor,
          ),
        ),

      /// сегодня
      if (!task.isFuture)
        _DateBarData(
          date: _now,
          color: _barColor,
          mark: MTProgressMark(
            child: Stack(
              alignment: Alignment.center,
              children: [
                MTCircle(size: _barHeight, color: bgL2Color, border: Border.all(color: _barColor)),
                MTCircle(size: _barHeight * 0.7, color: _pointerColor)
              ],
            ),
            size: Size(_barHeight, 0),
            color: _barColor,
          ),
        ),
    ];

    res.sort((a, b) => a.date.compareTo(b.date));
    return res.reversed;
  }

  double _dateRatio(DateTime dt) {
    final _sortedDates = _dateBarData.map((dbd) => dbd.date);
    final _maxDate = _sortedDates.first;
    final _minDate = _sortedDates.last;
    final _maxDateDays = _maxDate.difference(_minDate).inDays;
    return _maxDateDays > 0 ? (dt.difference(_minDate).inDays / _maxDateDays) : 1;
  }

  Widget _progressBar(BuildContext context, double prefixWidth) {
    return SizedBox(
      height: _barHeight,
      child: Row(
        children: [
          SizedBox(width: prefixWidth),
          Expanded(
            child: Stack(
              children: [
                ..._dateBarData.map((dbd) {
                  final ratio = _dateRatio(dbd.date);
                  return ratio > 0
                      ? MTProgress(
                          value: ratio,
                          color: dbd.color,
                          mark: dbd.mark,
                          border: Border(right: BorderSide(color: (dbd.mark?.color ?? fgL2Color).resolve(context))),
                        )
                      : const SizedBox();
                })
              ],
            ),
          ),
          SizedBox(width: _suffixWidth),
        ],
      ),
    );
  }

  Widget _timeChart(BuildContext context) {
    final prefixWidth = _barHeight * 0.7 + P2;

    return SizedBox(
      height: _barHeight + _borderWidth * 2,
      child: Stack(
        alignment: Alignment.center,
        children: [
          MTCard(
            elevation: 0,
            color: bgL2Color,
            // borderSide: BorderSide(color: _barColor.resolve(context), width: _borderWidth),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: task.isFuture ? null : _barColor.resolve(context),
                  width: prefixWidth,
                  padding: const EdgeInsets.symmetric(horizontal: P),
                  child: CalendarIcon(size: _barHeight * 0.8, color: fgL3Color),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  height: _barHeight,
                  width: _suffixWidth,
                  child: Image.asset('assets/icons/checkers.png'),
                ),
              ],
            ),
          ),
          _progressBar(context, prefixWidth),
        ],
      ),
    );
  }

  Widget _alignedDateLabel(BuildContext context, {required DateTime date, required String label, Color? color}) {
    return Align(
        alignment: Alignment.lerp(
          Alignment.topLeft,
          Alignment.topRight,
          _dateRatio(date),
        ) as Alignment,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            LightText('$label ', sizeScale: 1.2, color: color),
            H3('${date.strShort}', color: color),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (task.hasDueDate) ...[
        _alignedDateLabel(context, date: task.dueDate!, label: loc.task_due_date_label, color: _planMarkColor),
        SizedBox(height: _markSize.height * 0.9),
      ],
      _timeChart(context),
      if (task.hasEtaDate) ...[
        SizedBox(height: _markSize.height * 0.9),
        _alignedDateLabel(context, date: task.etaDate!, label: loc.task_eta_date_label, color: _etaMarkColor),
      ]
    ]);
  }
}
