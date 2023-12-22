// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../presenters/date.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';

class TaskDueDateField extends StatelessWidget {
  const TaskDueDateField(this._controller, {this.bottomDivider = false});
  final TaskController _controller;
  final bool bottomDivider;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    final date = _task.dueDate;

    return MTField(
      _controller.fData(TaskFCode.dueDate.index),
      leading: Container(),
      value: date != null
          ? Row(
              children: [
                BaseText(date.strMedium, padding: const EdgeInsets.only(right: P), maxLines: 1),
                BaseText.f2(DateFormat.EEEE().format(date), maxLines: 1),
              ],
            )
          : null,
      bottomDivider: bottomDivider,
      dividerIndent: P7 + P5,
      onTap: _task.canEdit ? () => _controller.datesController.selectDate(context, TaskFCode.dueDate) : null,
    );
  }
}
