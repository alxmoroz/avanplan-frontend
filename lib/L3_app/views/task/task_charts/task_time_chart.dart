// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_card.dart';
import '../../../components/mt_progress.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/date_presenter.dart';

class _DateBarData {
  _DateBarData({required this.date, this.color, this.mark});
  final DateTime date;
  final Color? color;
  final MTProgressMark? mark;
}

class TaskTimeChart extends StatelessWidget {
  const TaskTimeChart(this.task);
  final Task task;

  Color get _etaMarkColor => task.hasRisk || task.hasOverdue
      ? warningColor
      : task.isOk || task.isAhead
          ? greenColor
          : lightGreyColor;

  Color get _mainBarColor => (task.hasRisk || task.hasOverdue)
      ? lightWarningColor
      : task.isOk || task.isAhead
          ? lightGreenColor
          : darkBackgroundColor;

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
      if (task.state != TaskState.future)
        _DateBarData(
          date: _now,
          color: task.hasOverdue ? warningColor : _mainBarColor,
          mark: MTProgressMark(
            child: task.hasRisk || task.hasOverdue
                ? RiskIcon(size: onePadding * 3, color: task.hasOverdue ? dangerColor : warningColor)
                : task.state == TaskState.ok
                    ? OkIcon(size: onePadding * 3)
                    : NoInfoIcon(size: onePadding * 3),
            size: Size(onePadding * 3, 0),
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
    return Column(children: [
      NormalText('${loc.task_due_date_label} ${task.dueDate!.strMedium}', align: TextAlign.center),
      MTCard(
        color: backgroundColor,
        margin: EdgeInsets.symmetric(horizontal: onePadding, vertical: onePadding / 2),
        borderSide: BorderSide(color: lightGreyColor.resolve(context), width: 1),
        child: SizedBox(
          height: onePadding * 3,
          child: Row(
            children: [
              Container(color: _mainBarColor.resolve(context), width: onePadding * 2),
              Expanded(child: _timeProgressBar()),
              Container(width: onePadding * 2),
            ],
          ),
        ),
      ),
      if (task.hasEtaDate) NormalText('${loc.task_eta_date_label} ${task.etaDate!.strMedium}', align: TextAlign.center),
    ]);
  }
}
