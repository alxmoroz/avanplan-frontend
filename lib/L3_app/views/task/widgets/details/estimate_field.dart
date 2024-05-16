// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_estimate.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/estimate.dart';

class TaskEstimateField extends StatelessWidget {
  const TaskEstimateField(this._controller, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _controller;
  final bool compact;
  final bool hasMargin;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.estimate.index),
      leading: EstimateIcon(color: _task.canEstimate ? mainColor : f3Color),
      value: _task.hasEstimate || !_task.canEstimate ? BaseText(_task.estimateStr, maxLines: 1) : null,
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      onTap: _task.canEstimate ? _controller.selectEstimate : null,
    );
  }
}
