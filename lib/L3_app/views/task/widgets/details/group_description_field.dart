// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/linkify.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/title.dart';

class GroupDescriptionField extends StatelessWidget {
  const GroupDescriptionField(this._controller, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task;

  static const _maxLines = 20;

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.description.index),
      leading: DescriptionIcon(color: _task.canEdit ? mainColor : f2Color),
      value: _task.hasDescription ? MTLinkify(_task.description, maxLines: _maxLines) : null,
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      crossAxisAlignment: _task.hasDescription ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      onTap: _task.canEdit ? _controller.editDescription : null,
    );
  }
}
