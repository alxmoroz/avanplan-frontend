// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_card.dart';
import '../../../components/mt_circle.dart';
import '../../../components/mt_progress.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/date_presenter.dart';
import '../../../presenters/state_presenter.dart';

class _DateBarData {
  _DateBarData({required this.date, this.color, this.mark});
  final DateTime date;
  final Color? color;
  final MTProgressMark? mark;
}

class TaskTimeChart extends StatefulWidget {
  const TaskTimeChart(this.task);
  @protected
  final Task task;

  @override
  State<TaskTimeChart> createState() => _TaskTimeChartState();
}

class _TaskTimeChartState extends State<TaskTimeChart> {
  Task get task => widget.task;

  late int _maxDateSeconds;
  late DateTime _minDate;
  late Iterable<_DateBarData> _dateBarData;

  @override
  void initState() {
    _dateBarData = _makeDateBarData;
    final _sortedDates = _dateBarData.map((dbd) => dbd.date);
    final _maxDate = _sortedDates.first;
    _minDate = _sortedDates.last;
    _maxDateSeconds = _maxDate.difference(_minDate).inSeconds;

    super.initState();
  }

  double get _barHeight => onePadding * 2.5;
  double get _suffixWidth => _barHeight / 2;
  double get _borderWidth => 1.0;
  Color get _barColor => lightGreyColor;
  Color get _planMarkColor => darkGreyColor;

  Color get _etaMarkColor => task.hasOverdue
      ? dangerColor
      : task.hasRisk
          ? warningColor
          : task.isOk
              ? greenColor
              : darkGreyColor;

  Size get _markSize => Size(onePadding * 0.6, onePadding * 0.75);

  Iterable<_DateBarData> get _makeDateBarData {
    final _now = DateTime.now();
    final res = <_DateBarData>[
      /// старт
      _DateBarData(date: task.calculatedStartDate),

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
          color: task.hasOverdue ? warningColor : _barColor,
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

  double _dateRatio(DateTime dt) => _maxDateSeconds > 0 ? (dt.difference(_minDate).inSeconds / _maxDateSeconds) : 1;

  Widget _progressBar(BuildContext context, double prefixWidth) {
    return SizedBox(
      height: _barHeight,
      child: Row(
        children: [
          SizedBox(width: prefixWidth),
          Expanded(
            child: Stack(
              children: _dateBarData.map((dbd) {
                final ratio = _dateRatio(dbd.date);
                return ratio > 0
                    ? MTProgress(
                        value: ratio,
                        color: dbd.color,
                        mark: dbd.mark,
                        border: Border(right: BorderSide(color: (dbd.mark?.color ?? darkGreyColor).resolve(context))),
                      )
                    : const SizedBox();
              }).toList(),
            ),
          ),
          SizedBox(width: _suffixWidth),
        ],
      ),
    );
  }

  Widget _timeChart(BuildContext context) {
    final prefixWidth = _barHeight * 0.7 + onePadding * 2;

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
                  padding: EdgeInsets.symmetric(horizontal: onePadding),
                  child: CalendarIcon(size: _barHeight * 0.7, color: darkColor),
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
        child: NormalText('$label ${date.strShort}', color: color));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (task.hasDueDate) ...[
        _alignedDateLabel(context, date: task.dueDate!, label: loc.task_due_date_label, color: _planMarkColor),
        SizedBox(height: _markSize.height * 0.8),
      ],
      _timeChart(context),
      if (task.hasEtaDate) ...[
        SizedBox(height: _markSize.height * 0.8),
        _alignedDateLabel(context, date: task.etaDate!, label: loc.task_eta_date_label, color: _etaMarkColor),
      ]
    ]);
  }
}
