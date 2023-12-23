// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/date.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';

class TaskStartDateField extends StatelessWidget {
  const TaskStartDateField(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    final date = _task.startDate;

    return MTField(
      _controller.fData(TaskFCode.startDate.index),
      leading: CalendarIcon(color: _task.canEdit ? mainColor : f2Color),
      value: date != null
          ? Row(children: [
              BaseText(date.strMedium, padding: const EdgeInsets.only(right: P), maxLines: 1),
              BaseText.f2(DateFormat.EEEE().format(date), maxLines: 1),
            ])
          : null,
      bottomDivider: _task.hasDueDate || _task.canEdit,
      dividerIndent: P10,
      onTap: _task.canEdit ? () => _controller.datesController.selectDate(context, TaskFCode.startDate) : null,
    );
  }
}
