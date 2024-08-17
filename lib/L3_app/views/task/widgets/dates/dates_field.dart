// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/date.dart';
import '../../controllers/task_controller.dart';
import 'dates_dialog.dart';

class TaskDatesField extends StatelessWidget {
  const TaskDatesField(this._controller, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    final startDate = _task.startDate;
    final dueDate = _task.dueDate;
    final repeat = _task.repeat;

    final dates = Row(children: [
      if (startDate != null)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (dueDate == null) BaseText.f2('${loc.task_start_date_label}: ', maxLines: 1),
            BaseText(startDate.strMedium, maxLines: 1),
            if (dueDate == null) Flexible(child: BaseText.f2(', ${DateFormat.EEEE().format(startDate)}', maxLines: 1)),
          ],
        ),
      if (dueDate != null)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (startDate == null) BaseText.f2('${loc.task_due_date_label}: ', maxLines: 1) else const BaseText(' – ', maxLines: 1),
            BaseText(dueDate.strMedium, maxLines: 1),
            if (startDate == null) Flexible(child: BaseText.f2(', ${DateFormat.EEEE().format(dueDate)}', maxLines: 1)),
          ],
        ),
    ]);

    return MTField(
      MTFieldData(-1, placeholder: loc.task_dates),
      leading: const CalendarIcon(),
      value: startDate != null || dueDate != null || repeat != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                dates,
                if (repeat != null)
                  Row(
                    children: [
                      const RepeatIcon(size: P3),
                    ],
                  ),
              ],
            )
          : null,
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      onTap: () => showTaskDatesDialog(_controller),
    );
  }
}
