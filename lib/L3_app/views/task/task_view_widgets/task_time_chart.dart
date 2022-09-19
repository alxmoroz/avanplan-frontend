// Copyright (c) 2022. Alexandr Moroz

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
  _DateBarData({required this.date, required this.color, this.topMark = false, this.bottomMark = false});
  final DateTime date;
  final Color color;
  final bool topMark;
  final bool bottomMark;
}

class TaskTimeChart extends StatelessWidget {
  const TaskTimeChart(this.task);
  final Task task;

  bool get showProgress => task.hasEtaDate || task.hasOverdue;

  Iterable<_DateBarData> get _dateBarData {
    final res = <_DateBarData>[
      if (task.hasDueDate) _DateBarData(date: task.dueDate!, color: darkBackgroundColor, bottomMark: true),
      if (task.hasEtaDate) _DateBarData(date: task.etaDate!, color: task.hasRisk ? lightWarningColor : bgGreenColor, topMark: true),
    ];
    if (task.hasOverdue) {
      res.add(_DateBarData(date: DateTime.now(), color: warningColor, topMark: true));
    }
    res.sort((a, b) => a.date.compareTo(b.date));
    return res.reversed;
  }

  Widget _timeProgressBar(BuildContext context, {required Size markSize}) => Stack(
        children: [
          ..._dateBarData.map((dbd) {
            final ratio = task.dateRatio(dbd.date);
            return MTProgress(
              value: ratio,
              color: dbd.color,
              padding: EdgeInsets.zero,
              child: SizedBox(height: onePadding * 1.5),
              border: ratio < 1 ? const Border(right: BorderSide(width: 0)) : null,
              showTopMark: dbd.topMark,
              showBottomMark: dbd.bottomMark,
              markSize: markSize,
            );
          }).toList(),
        ],
      );

  Widget _alignedDateLabel(BuildContext context, {required DateTime date, required String label, required bool up}) => Align(
      alignment: Alignment.lerp(
        Alignment.topLeft,
        Alignment.topRight,
        task.dateRatio(date),
      ) as Alignment,
      child: SmallText('$label ${date.strShort}'));

  @override
  Widget build(BuildContext context) {
    final markSize = Size(onePadding * 0.5, onePadding * 0.7);

    return Row(children: [
      Column(children: [
        if (showProgress) const SmallText(''),
        calendarIcon(context, size: onePadding * 1.9, color: darkGreyColor),
        if (showProgress && task.hasDueDate) const SmallText(''),
      ]),
      if (showProgress)
        Expanded(
          child: Column(children: [
            _alignedDateLabel(
              context,
              date: task.hasEtaDate ? task.etaDate! : DateTime.now(),
              label: task.hasEtaDate ? loc.task_eta_date_label : loc.today_date_label,
              up: true,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: markSize.height),
              child: _timeProgressBar(context, markSize: markSize),
            ),
            if (task.hasDueDate) _alignedDateLabel(context, date: task.dueDate!, label: loc.task_due_date_label, up: false),
          ]),
        )
      else if (task.hasDueDate)
        SmallText(' ${loc.task_due_date_label} ${task.dueDate!.strLong}', align: TextAlign.left),
    ]);
  }
}
