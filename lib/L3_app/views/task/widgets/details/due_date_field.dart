// Copyright (c) 2023. Alexandr Moroz

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

class TaskDueDateField extends StatelessWidget {
  const TaskDueDateField(this._controller, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    final date = _task.dueDate;

    return MTField(
      _controller.fData(TaskFCode.dueDate.index),
      leading: CalendarIcon(color: _task.canEdit ? mainColor : f2Color, endMark: true),
      value: date != null
          ? Row(
              children: [
                BaseText(date.strMedium, padding: const EdgeInsets.only(right: P), maxLines: 1),
                Expanded(child: BaseText.f2(DateFormat.EEEE().format(date), maxLines: 1)),
              ],
            )
          : null,
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      onTap: _task.canEdit ? () => _controller.datesController.selectDate(context, TaskFCode.dueDate) : null,
    );
  }
}
