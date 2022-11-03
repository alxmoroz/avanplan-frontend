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
  @protected
  final Task task;
  bool get _isFuture => task.state == TaskState.future;

  double get _barHeight => onePadding * 3;

  Color get _etaMarkColor => task.hasOverdue
      ? dangerColor
      : task.hasRisk
          ? warningColor
          : task.isOk
              ? greenColor
              : darkGreyColor;

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
          color: task.hasOverdue ? lightWarningColor : _mainBarColor,
          mark: MTProgressMark(
            child: task.hasRisk || task.hasOverdue
                ? RiskIcon(size: _barHeight, color: task.hasOverdue ? dangerColor : warningColor, solid: true)
                : task.isOk
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

  String get _dueText => '${loc.task_due_date_label} ${task.dueDate!.strMedium}';
  String get _etaText => '${loc.task_eta_date_label} ${task.etaDate!.strMedium}';

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      MTCard(
        color: backgroundColor,
        borderSide: BorderSide(color: lightGreyColor.resolve(context), width: 1),
        child: SizedBox(
          height: _barHeight,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                color: _isFuture ? null : _mainBarColor.resolve(context),
                width: _barHeight * 1.7 + onePadding * 2,
                padding: EdgeInsets.symmetric(horizontal: onePadding),
                child: CalendarIcon(size: _barHeight * 0.7, color: darkGreyColor),
              ),
              Expanded(child: _timeProgressBar()),
              Container(width: _barHeight),
            ],
          ),
        ),
      ),
      Row(children: [
        if (task.hasEtaDate) ...[
          Expanded(child: NormalText(task.hasRisk ? _dueText : _etaText, color: task.isOk ? greenColor : null)),
          Expanded(child: NormalText(task.hasRisk ? _etaText : _dueText, align: TextAlign.right, color: task.hasRisk ? warningColor : null)),
        ] else
          NormalText(_dueText, align: TextAlign.center),
      ]),
    ]);
  }
}
