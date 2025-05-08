// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/date.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/dates.dart';

class TaskDueDateField extends StatelessWidget {
  const TaskDueDateField(this._tc, {super.key});
  final TaskController _tc;

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    final date = t.dueDate;
    final canEdit = _tc.canEdit;

    return MTField(
      _tc.fData(TaskFCode.dueDate.index),
      showLabel: true,
      leading: CalendarIcon(color: canEdit ? mainColor : f2Color),
      value: date != null
          ? Row(
              children: [
                BaseText(date.strMedium, color: canEdit ? null : f2Color, maxLines: 1),
                BaseText.f2(', ${DateFormat.EEEE().format(date)}', maxLines: 1),
              ],
            )
          : null,
      margin: const EdgeInsets.only(top: P3),
      onTap: canEdit ? () => _tc.selectDate(context, TaskFCode.dueDate) : null,
    );
  }
}
