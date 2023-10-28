// Copyright (c) 2023. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/estimate_value.dart';
import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/ws_estimates.dart';
import '../../../components/constants.dart';
import '../../../components/select_dialog.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/workspace.dart';
import 'task_controller.dart';

class EstimateController {
  EstimateController(this._taskController);
  final TaskController _taskController;

  Task get task => _taskController.task;

  /// оценка

  Future _reset() async {
    final oldValue = task.estimate;
    task.estimate = null;
    if (!(await _taskController.saveField(TaskFCode.estimate))) {
      task.estimate = oldValue;
    }
  }

  Future select() async {
    final currentId = task.ws.estimateValueForValue(task.estimate)?.id;
    final selectedEstimateValue = await showMTSelectDialog<EstimateValue>(
      task.ws.sortedEstimateValues,
      currentId,
      loc.task_estimate_placeholder,
      valueBuilder: (_, e) {
        final selected = currentId == e.id;
        final text = '${e.value}';
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selected) const SizedBox(width: P2),
            selected ? H3(text, maxLines: 1) : BaseText(text, maxLines: 1),
            BaseText.f2(' ${task.ws.estimateUnitCode}', maxLines: 1),
          ],
        );
      },
      onReset: _reset,
    );

    if (selectedEstimateValue != null) {
      final oldValue = task.estimate;
      task.estimate = selectedEstimateValue.value;
      if (!(await _taskController.saveField(TaskFCode.estimate))) {
        task.estimate = oldValue;
      }
    }
  }
}
