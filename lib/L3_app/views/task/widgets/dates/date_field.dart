// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/date.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/dates.dart';

class TaskDateField extends StatelessWidget {
  const TaskDateField(this._tc, this._fCode, {super.key});
  final TaskController _tc;
  final TaskFCode _fCode;

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    final date = _fCode == TaskFCode.startDate ? t.startDate : t.dueDate;
    final canEdit = _tc.canEdit;

    return MTField(
      _tc.fData(_fCode.index),
      showLabel: true,
      leading: CalendarIcon(color: canEdit ? mainColor : f2Color),
      value: date != null
          ? Row(
              children: [
                BaseText(date.strMedium, color: canEdit ? null : f2Color, maxLines: 1),
                BaseText.f2(', ${DateFormat.EEEE().format(date)}', maxLines: 1),
              ],
            )
          : null,
      margin: const EdgeInsets.only(top: P3),
      trailing: date != null
          ? MTButton.icon(
              const DeleteIcon(color: f3Color),
              padding: const EdgeInsets.symmetric(vertical: DEF_VP / 2).copyWith(left: DEF_VP, right: 0),
              onTap: () => _tc.resetDate(_fCode),
            )
          : null,
      onTap: canEdit ? () => _tc.selectDate(context, _fCode) : null,
    );
  }
}
