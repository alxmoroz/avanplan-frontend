// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/progress.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date.dart';

class _DateBarData {
  _DateBarData({required this.date, this.color, this.mark});
  final DateTime date;
  final Color? color;
  final MTProgressMark? mark;
}

class TimingChart extends StatelessWidget {
  const TimingChart(this._task, {this.showDueLabel = true});
  final Task _task;
  final bool showDueLabel;

  static const _barHeight = P6;
  static const _borderWidth = P;
  static const _borderR = _barHeight / 2;
  static const _markSize = Size(P2, P2);
  static const _barColor = mainColor;

  Color get _etaMarkColor => _task.hasRisk
      ? warningColor
      : _task.hasOverdue
          ? dangerColor
          : _task.isOk
              ? greenColor
              : mainColor;

  Iterable<_DateBarData> get _dateBarData {
    final _now = DateTime.now();
    final res = <_DateBarData>[
      /// старт
      _DateBarData(date: _task.calculatedStartDate),

      /// сегодня
      if (!_task.isFuture) _DateBarData(date: _now, color: _task.hasOverdue ? _etaMarkColor : _barColor),

      /// срок
      if (_task.hasDueDate)
        _DateBarData(
          date: _task.dueDate!,
          color: _task.dueDate!.isBefore(_now) ? _barColor : null,
          mark: showDueLabel
              ? MTProgressMark(
                  const CaretIcon(size: _markSize),
                  size: Size(_markSize.width, -_markSize.height),
                )
              : null,
        ),

      /// прогноз
      if (_task.hasEtaDate)
        _DateBarData(
          date: _task.etaDate!,
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
    final _sortedDates = _dateBarData.map((dbd) => dbd.date);
    final _maxDate = _sortedDates.first;
    final _minDate = _sortedDates.last;
    final _maxDateDays = _maxDate.difference(_minDate).inDays;
    final _passDays = dt.difference(_minDate).inDays;

    return _maxDateDays > 0 ? ((_passDays > 0 ? _passDays : 1) / _maxDateDays) : 1;
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
        D5(label.toLowerCase(), color: color),
        const Spacer(),
        D4('${date.strMedium}', color: color),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (_task.hasDueDate && showDueLabel) ...[
        _dateLabel(context, date: _task.dueDate!, label: loc.task_due_date_label, color: f2Color),
        SizedBox(height: _markSize.height + P_2),
      ],
      _timeChart(context),
      if (_task.hasEtaDate) ...[
        SizedBox(height: _markSize.height + P_2),
        _dateLabel(context, date: _task.etaDate!, label: loc.task_eta_date_label, color: _etaMarkColor),
      ]
    ]);
  }
}
