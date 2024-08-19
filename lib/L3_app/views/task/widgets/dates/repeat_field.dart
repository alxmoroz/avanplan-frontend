// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/date_repeat.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'repeat_dialog.dart';

class TaskRepeatField extends StatelessWidget {
  const TaskRepeatField(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    final repeat = _task.repeat;

    return MTField(
      _controller.fData(TaskFCode.repeat.index),
      leading: RepeatIcon(color: _task.canEdit ? mainColor : f2Color),
      value: repeat != null ? BaseText(repeat.localizedString, maxLines: 1) : null,
      margin: const EdgeInsets.only(top: P3),
      onTap: _task.canEdit ? () => showTaskRepeatDialog(_controller) : null,
    );
  }
}
