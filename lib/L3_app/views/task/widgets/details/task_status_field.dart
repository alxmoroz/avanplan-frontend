// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../usecases/task_status.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/status.dart';

class TaskStatusField extends StatelessWidget {
  const TaskStatusField(this._tc, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _tc;
  final bool compact;
  final bool hasMargin;

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    final ro = !_tc.canSetStatus;

    return MTField(
      _tc.fData(TaskFCode.status.index),
      leading: BoardIcon(size: DEF_TAPPABLE_ICON_SIZE - P_2, color: ro ? f3Color : mainColor),
      value: BaseText('${t.status}', color: ro ? f2Color : null),
      compact: compact,
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      onTap: _tc.canSetStatus ? () => _tc.selectStatus(context) : null,
    );
  }
}
