// Copyright (c) 2024. Alexandr Moroz

import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/estimate_value.dart';
import '../../../../L1_domain/entities_extensions/ws_estimates.dart';
import '../../../components/constants.dart';
import '../../../components/select_dialog.dart';
import '../../../components/text.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/workspace.dart';
import '../controllers/task_controller.dart';
import 'edit.dart';

extension EstimateUC on TaskController {
  Future _reset() async {
    final oldValue = task.estimate;
    task.estimate = null;
    if (!(await saveField(TaskFCode.estimate))) {
      task.estimate = oldValue;
    }
  }

  Future selectEstimate() async {
    final oldValue = task.estimate;
    final currentId = task.ws.estimateValueForValue(oldValue)?.id;
    final selectedEstimateValue = await showMTSelectDialog<EstimateValue>(
      task.ws.sortedEstimateValues,
      currentId,
      loc.task_estimate_placeholder,
      parentPageTitle: task.title,
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

    if (selectedEstimateValue != null && oldValue != selectedEstimateValue.value) {
      task.estimate = selectedEstimateValue.value;
      if (!(await saveField(TaskFCode.estimate))) {
        task.estimate = oldValue;
      }
    }
  }
}
