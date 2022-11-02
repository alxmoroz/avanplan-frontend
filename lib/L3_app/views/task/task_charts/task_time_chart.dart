// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_card.dart';
import '../../../components/mt_progress.dart';

class _DateBarData {
  _DateBarData({required this.date, this.color, this.mark});
  final DateTime date;
  final Color? color;
  final MTProgressMark? mark;
}

class TaskTimeChart extends StatelessWidget {
  const TaskTimeChart(this.task);
  @protected
  final Task task;
  bool get _isFuture => task.state == TaskState.future;
  bool get _isOverdue => task.state == TaskState.overdue;
  bool get _isRisk => task.state == TaskState.risk;
  bool get _isOk => task.state == TaskState.ok || task.state == TaskState.ahead;

  double get _barHeight => onePadding * 3;

  Color get _etaMarkColor => _isOverdue
      ? dangerColor
      : _isRisk
          ? warningColor
          : _isOk
              ? greenColor
              : darkGreyColor;

  // Color get _mainBarColor => (task.hasRisk || task.hasOverdue)
  //     ? lightWarningColor
  //     : task.isOk || task.isAhead
  //         ? lightGreenColor
  //         : darkBackgroundColor;

  Color get _mainBarColor => borderColor;
  DateTime get _now => DateTime.now();

  Iterable<_DateBarData> get _dateBarData {
    final res = <_DateBarData>[
      // старт
      _DateBarData(date: task.calculatedStartDate, color: backgroundColor),
      // план
      if (task.hasDueDate)
        _DateBarData(
          date: task.dueDate!,
          color: _now.isAfter(task.dueDate!) ? _mainBarColor : backgroundColor,
          mark: const MTProgressMark(color: darkGreyColor),
        ),
      // прогноз
      if (task.hasEtaDate) _DateBarData(date: task.etaDate!, color: backgroundColor, mark: MTProgressMark(color: _etaMarkColor)),
      // сегодня
      if (!_isFuture)
        _DateBarData(
          date: _now,
          color: _isOverdue ? lightWarningColor : _mainBarColor,
          mark: MTProgressMark(
            child: _isRisk || _isOverdue
                ? RiskIcon(size: _barHeight, color: _isOverdue ? dangerColor : warningColor, solid: true)
                : _isOk
                    ? OkIcon(size: _barHeight)
                    : NoInfoIcon(size: _barHeight),
            size: Size(_barHeight, 0),
          ),
        ),
    ];

    res.sort((a, b) => a.date.compareTo(b.date));
    return res.reversed;
  }

  Iterable<DateTime> get _sortedDates => _dateBarData.map((dbd) => dbd.date);
  DateTime get _minDate => _sortedDates.last;
  DateTime get _maxDate => _sortedDates.first;
  int get _maxDateSeconds => _maxDate.difference(_minDate).inSeconds;
  double dateRatio(DateTime dt) => _maxDateSeconds > 0 ? (dt.difference(_minDate).inSeconds / _maxDateSeconds) : 1;

  Widget _timeProgressBar() => Stack(
        children: [
          ..._dateBarData.map((dbd) => MTProgress(value: dateRatio(dbd.date), color: dbd.color, mark: dbd.mark)).toList(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return MTCard(
      color: backgroundColor,
      borderSide: BorderSide(color: lightGreyColor.resolve(context), width: 1),
      child: SizedBox(
        height: _barHeight,
        child: Row(
          children: [
            Container(color: _isFuture ? null : _mainBarColor.resolve(context), width: _barHeight),
            Expanded(child: _timeProgressBar()),
            Container(width: _barHeight),
          ],
        ),
      ),
    );
  }
}
