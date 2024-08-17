// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/date.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/dates.dart';

class TaskStartDateField extends StatelessWidget {
  const TaskStartDateField(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    final date = _task.startDate;

    return MTField(
      _controller.fData(TaskFCode.startDate.index),
      leading: CalendarIcon(color: _task.canEdit ? mainColor : f2Color, startMark: true),
      value: date != null
          ? Row(
              children: [
                BaseText(date.strMedium, maxLines: 1),
                BaseText.f2(', ${DateFormat.EEEE().format(date)}', maxLines: 1),
              ],
            )
          : null,
      margin: const EdgeInsets.only(top: P3),
      onTap: _task.canEdit ? () => _controller.selectDate(context, TaskFCode.startDate) : null,
    );
  }
}
