// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/date_repeat.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../controllers/task_controller.dart';
import 'repeat_dialog.dart';

class TaskRepeatField extends StatelessWidget {
  const TaskRepeatField(this._tc, {super.key});
  final TaskController _tc;

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    final repeat = t.repeat;
    final canEdit = _tc.canEdit;

    return MTField(
      _tc.fData(TaskFCode.repeat.index),
      leading: RepeatIcon(color: canEdit ? mainColor : f2Color),
      value: repeat != null ? BaseText(repeat.localizedString, color: canEdit ? null : f2Color, maxLines: 1) : null,
      margin: const EdgeInsets.only(top: P3),
      onTap: canEdit ? () => showTaskRepeatDialog(_tc) : null,
    );
  }
}
