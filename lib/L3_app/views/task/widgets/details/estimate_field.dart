// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/workspace.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';

class TaskEstimateField extends StatelessWidget {
  const TaskEstimateField(this._controller, {this.compact = false});
  final TaskController _controller;
  final bool compact;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.estimate.index),
      leading: EstimateIcon(color: _task.canEstimate ? mainColor : f3Color),
      value: _task.hasEstimate ? BaseText('${(_task.openedVolume ?? _task.estimate)?.round()} ${_task.ws.estimateUnitCode}', maxLines: 1) : null,
      compact: compact,
      onTap: _task.canEstimate ? _controller.estimateController.select : null,
    );
  }
}
