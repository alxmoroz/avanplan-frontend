// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_progress.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/date_presenter.dart';

class _DateBarData {
  _DateBarData({required this.date, required this.color, this.mark});
  final DateTime date;
  final Color color;
  final MTProgressMark? mark;
}

class TaskTimeChart extends StatelessWidget {
  const TaskTimeChart(this.task);
  final Task task;

  bool get _showProgress => task.hasEtaDate || task.hasOverdue;

  Iterable<_DateBarData> get _dateBarData {
    final res = <_DateBarData>[
      if (task.hasDueDate)
        _DateBarData(
          date: task.dueDate!,
          color: task.hasRisk ? darkBackgroundColor : bgGreenColor,
          mark: const MTProgressMark(showBottom: true),
        ),
      if (task.hasEtaDate)
        _DateBarData(date: task.etaDate!, color: task.hasRisk ? lightWarningColor : darkBackgroundColor, mark: const MTProgressMark(showTop: true)),
    ];
    res.add(_DateBarData(
        date: DateTime.now(),
        color: warningColor,
        mark: MTProgressMark(
          showTop: true,
          child: todayIcon(size: onePadding * 1.2),
          size: Size(onePadding * 1.2, onePadding * 0.7),
        )));
    res.sort((a, b) => a.date.compareTo(b.date));
    return res.reversed;
  }

  double get _topMarkMaxHeight => _dateBarData
      .where((dbd) => dbd.mark != null && dbd.mark!.showTop == true)
      .map((dbd) => dbd.mark!.mSize.height)
      .fold(0, (h1, h2) => max(h1, h2));

  double get _bottomMarkMaxHeight => _dateBarData
      .where((dbd) => dbd.mark != null && dbd.mark!.showBottom == true)
      .map((dbd) => dbd.mark!.mSize.height)
      .fold(0, (h1, h2) => max(h1, h2));

  Widget _timeProgressBar() => Stack(
        children: [
          ..._dateBarData.map((dbd) {
            final ratio = task.dateRatio(dbd.date);
            return MTProgress(
              value: ratio,
              color: dbd.color,
              padding: EdgeInsets.zero,
              child: SizedBox(height: onePadding * 1.5),
              border: (ratio > 0 && ratio < 1) ? const Border(right: BorderSide(width: 0)) : null,
              mark: dbd.mark,
            );
          }).toList(),
        ],
      );

  Widget _alignedDateLabel(BuildContext context, {required DateTime date, required String label, required bool up}) {
    return Align(
        alignment: Alignment.lerp(
          Alignment.topLeft,
          Alignment.topRight,
          task.dateRatio(date),
        ) as Alignment,
        child: SmallText('$label ${date.strShort}'));
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Column(children: [
        if (_showProgress && task.hasEtaDate) const SmallText(''),
        calendarIcon(context, size: onePadding * 2, color: darkGreyColor),
        if (_showProgress && task.hasDueDate) const SmallText(''),
      ]),
      if (_showProgress)
        Expanded(
          child: Column(children: [
            if (task.hasEtaDate) _alignedDateLabel(context, date: task.etaDate!, label: loc.task_eta_date_label, up: true),
            Padding(
              padding: EdgeInsets.only(top: _topMarkMaxHeight, bottom: _bottomMarkMaxHeight, left: onePadding / 4, right: onePadding / 4),
              child: _timeProgressBar(),
            ),
            if (task.hasDueDate) _alignedDateLabel(context, date: task.dueDate!, label: loc.task_due_date_label, up: false),
          ]),
        )
      else if (task.hasDueDate)
        SmallText(' ${loc.task_due_date_label} ${task.dueDate!.strLong}', align: TextAlign.left),
    ]);
  }
}
