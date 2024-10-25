// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/date.dart';
import '../../../../presenters/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/dates.dart';

class TaskDueDateField extends StatelessWidget {
  const TaskDueDateField(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    final date = _task.dueDate;

    return MTField(
      _controller.fData(TaskFCode.dueDate.index),
      leading: CalendarIcon(color: _task.canEdit ? mainColor : f2Color, endMark: true),
      value: date != null
          ? Row(
              children: [
                BaseText(date.strMedium, maxLines: 1),
                BaseText.f2(', ${DateFormat.EEEE().format(date)}', maxLines: 1),
              ],
            )
          : null,
      margin: const EdgeInsets.only(top: P3),
      onTap: _task.canEdit ? () => _controller.selectDate(context, TaskFCode.dueDate) : null,
    );
  }
}
