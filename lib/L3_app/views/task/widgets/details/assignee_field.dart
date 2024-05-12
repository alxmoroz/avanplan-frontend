// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/person.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/assignee.dart';

class TaskAssigneeField extends StatelessWidget {
  const TaskAssigneeField(this._controller, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTField(
        _controller.fData(TaskFCode.assignee.index),
        leading: _task.hasAssignee
            ? _task.assignee!.icon(P6 / 2, borderColor: mainColor)
            : PersonIcon(
                color: _task.canAssign ? mainColor : f2Color,
              ),
        value: _task.hasAssignee ? BaseText('${_task.assignee}', color: _task.canAssign ? null : f2Color, maxLines: 1) : null,
        compact: compact,
        margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
        onTap: _task.canAssign ? _controller.startAssign : null,
      ),
    );
  }
}
