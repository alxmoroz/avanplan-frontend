// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../usecases/task_status.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/status.dart';

class TaskStatusField extends StatelessWidget {
  const TaskStatusField(this._controller, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.status.index),
      leading: const BoardIcon(size: P5),
      value: BaseText('${_task.status}'),
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      onTap: _task.canSetStatus ? () => _controller.selectStatus(context) : null,
    );
  }
}
