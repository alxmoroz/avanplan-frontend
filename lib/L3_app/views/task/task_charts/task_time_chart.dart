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
  _DateBarData({required this.date, required this.color, this.mark});
  final DateTime date;
  final Color? color;
  final MTProgressMark? mark;
}

class TaskTimeChart extends StatelessWidget {
  const TaskTimeChart(this.task);
  final Task task;

  Iterable<_DateBarData> get _dateBarData {
    final res = <_DateBarData>[
      _DateBarData(
        date: task.calculatedStartDate,
        color: darkBackgroundColor,
      ),
      if (task.hasDueDate)
        _DateBarData(
          date: task.dueDate!,
          color: task.hasEtaDate && task.dueDate!.isAfter(task.etaDate!) ? lightGreenColor : backgroundColor,
          mark: const MTProgressMark(showBottom: true),
        ),
      if (task.hasEtaDate)
        _DateBarData(
          date: task.etaDate!,
          color: task.isOk && task.etaDate!.isAfter(task.dueDate!)
              ? lightGreenColor
              : task.hasRisk
                  ? lightWarningColor
                  : darkBackgroundColor,
          mark: const MTProgressMark(showTop: true),
        ),
    ];
    res.add(_DateBarData(
        date: DateTime.now(),
        color: task.hasOverdue ? warningColor : darkBackgroundColor,
        mark: [TaskState.future].contains(task.state)
            ? null
            : MTProgressMark(
                showTop: true,
                child: task.state == TaskState.risk
                    ? RiskIcon(size: onePadding * 4)
                    : task.state == TaskState.ok
                        ? OkIcon(size: onePadding * 3)
                        : NoInfoIcon(size: onePadding * 3),
                size: Size(onePadding * 3, onePadding * 0.6),
              )));
    res.sort((a, b) => a.date.compareTo(b.date));
    return res.reversed;
  }

  // double get _topMarkMaxHeight => _dateBarData
  //     .where((dbd) => dbd.mark != null && dbd.mark!.showTop == true)
  //     .map((dbd) => dbd.mark!.mSize.height)
  //     .fold(0, (h1, h2) => max(h1, h2));
  //
  // double get _bottomMarkMaxHeight => _dateBarData
  //     .where((dbd) => dbd.mark != null && dbd.mark!.showBottom == true)
  //     .map((dbd) => dbd.mark!.mSize.height)
  //     .fold(0, (h1, h2) => max(h1, h2));

  /// диаграмма сроков
  DateTime get _now => DateTime.now();
  Iterable<DateTime> get _sortedDates {
    final dates = [
      task.calculatedStartDate,
      if (task.hasDueDate) task.dueDate!,
      if (task.hasEtaDate) task.etaDate!,
      _now,
    ];
    if (dates.length > 1) {
      dates.sort((d1, d2) => d1.compareTo(d2));
    }
    return dates;
  }

  DateTime get _minDate => _sortedDates.first;
  DateTime get _maxDate => _sortedDates.last;
  int get _maxDateSeconds => _maxDate.difference(_minDate).inSeconds;
  double dateRatio(DateTime dt) => _maxDateSeconds > 0 ? (dt.difference(_minDate).inSeconds / _maxDateSeconds) : 1;

  Widget _timeProgressBar() => Stack(
        children: [
          ..._dateBarData.map((dbd) {
            final ratio = dateRatio(dbd.date);
            return MTProgress(
              value: ratio,
              color: dbd.color,
              padding: EdgeInsets.zero,
              child: SizedBox(height: onePadding * 3),
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
          dateRatio(date),
        ) as Alignment,
        child: SmallText('$label ${date.strShort}'));
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      NormalText('${loc.task_due_date_label} ${task.dueDate!.strMedium}', align: TextAlign.center),
      MTCard(
        margin: EdgeInsets.symmetric(horizontal: onePadding * 2, vertical: onePadding / 2),
        borderSide: BorderSide(color: lightGreyColor.resolve(context), width: 1),
        child: _timeProgressBar(),
      ),
      if (task.hasEtaDate) _alignedDateLabel(context, date: task.etaDate!, label: loc.task_eta_date_label, up: true),
    ]);
  }
}
