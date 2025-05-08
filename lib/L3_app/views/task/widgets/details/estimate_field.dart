// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities_extensions/task_params.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_estimate.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/estimate.dart';

class TaskEstimateField extends StatelessWidget {
  const TaskEstimateField(this._tc, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _tc;
  final bool compact;
  final bool hasMargin;

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    final canEstimate = _tc.canEstimate;
    return MTField(
      _tc.fData(TaskFCode.estimate.index),
      leading: EstimateIcon(color: canEstimate ? mainColor : f3Color),
      value: t.hasEstimate ? BaseText(t.estimateStr, maxLines: 1, color: canEstimate ? null : f2Color) : null,
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      onTap: canEstimate ? _tc.selectEstimate : null,
    );
  }
}
