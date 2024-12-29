// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/date_repeat.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import 'dates_dialog.dart';

class TaskDatesField extends StatelessWidget {
  const TaskDatesField(this._tc, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _tc;
  final bool compact;
  final bool hasMargin;

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    final ro = !_tc.canEdit;
    final startDate = t.startDate;
    final dueDate = t.dueDate;
    final repeat = t.repeat;

    final mainTextColor = ro ? f2Color : null;

    final dates = Row(children: [
      if (startDate != null)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            BaseText(startDate.strMedium, maxLines: 1, color: mainTextColor),
            if (dueDate == null) Flexible(child: BaseText.f2(', ${DateFormat.E().format(startDate)}', maxLines: 1)),
          ],
        ),
      if (dueDate != null)
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (startDate != null) BaseText(' – ', maxLines: 1, color: mainTextColor),
            BaseText(dueDate.strMedium, maxLines: 1, color: mainTextColor),
            if (startDate == null) Flexible(child: BaseText.f2(', ${DateFormat.E().format(dueDate)}', maxLines: 1)),
          ],
        ),
    ]);

    return MTField(
      MTFieldData(
        -1,
        placeholder: _tc.canShowRepeatField ? loc.task_dates_repeat : loc.task_dates,
        label: dueDate == null
            ? loc.task_start_date_label
            : startDate == null
                ? loc.task_due_date_label
                : '',
      ),
      showLabel: true,
      leading: CalendarIcon(color: ro ? f3Color : mainColor),
      value: startDate != null || dueDate != null || repeat != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                dates,
                if (repeat != null) ...[
                  const SizedBox(height: P),
                  Row(
                    children: [
                      const RepeatIcon(size: P3, color: f2Color),
                      const SizedBox(width: P),
                      Expanded(
                        child: SmallText(
                          repeat.localizedString,
                          maxLines: 1,
                          color: ro ? f2Color : null,
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            )
          : null,
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      onTap: ro ? null : () => showTaskDatesDialog(_tc),
    );
  }
}
