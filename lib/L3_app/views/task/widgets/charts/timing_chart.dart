// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_card.dart';
import '../../../../components/mt_circle.dart';
import '../../../../components/mt_progress.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date_presenter.dart';
import '../../../../presenters/state_presenter.dart';

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
  double get _borderWidth => 1.0;
  Color get _barColor => lightGreyColor;
  Color get _planMarkColor => task.hasOverdue ? dangerColor : greyColor;

  Color get _etaMarkColor => task.hasRisk
      ? warningColor
      : task.isOk
          ? greenColor
          : darkGreyColor;

  Size get _markSize => const Size(P * 0.7, P * 0.9);

  Iterable<_DateBarData> get _dateBarData {
    final _now = DateTime.now();
    final res = <_DateBarData>[
      /// старт
      _DateBarData(date: task.startDate!),

      /// план
      if (task.hasDueDate)
        _DateBarData(
          date: task.dueDate!,
          color: task.hasOverdue ? _barColor : null,
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
                MTCircle(size: _barHeight, color: darkBackgroundColor, border: Border.all(color: task.hasOverdue ? warningColor : _barColor)),
                task.stateIcon(size: _barHeight * 0.7),
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
                          border: Border(right: BorderSide(color: (dbd.mark?.color ?? greyColor).resolve(context))),
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
            color: backgroundColor,
            borderSide: BorderSide(color: lightGreyColor.resolve(context), width: _borderWidth),
            child: Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  color: task.isFuture ? null : _barColor.resolve(context),
                  width: prefixWidth,
                  padding: const EdgeInsets.symmetric(horizontal: P),
                  child: CalendarIcon(size: _barHeight * 0.7, color: darkGreyColor),
                ),
                const Spacer(),
                Container(
                  alignment: Alignment.centerLeft,
                  height: _barHeight,
                  width: _suffixWidth,
                  child: Image.asset('assets/images/checkers.png'),
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
            LightText('$label ', sizeScale: 1.1, color: color),
            H4('${date.strShort}', color: color),
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
