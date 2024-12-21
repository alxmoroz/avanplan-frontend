// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities_extensions/task_members.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../presenters/ws_member.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/assignee.dart';

class TaskAssigneeField extends StatelessWidget {
  const TaskAssigneeField(this._tc, {super.key, this.compact = false, this.hasMargin = false});
  final TaskController _tc;
  final bool compact;
  final bool hasMargin;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _tc.task;
      final canAssign = _tc.canAssign;
      final assignee = t.assignee;
      return MTField(
        _tc.fData(TaskFCode.assignee.index),
        leading: assignee?.icon(DEF_TAPPABLE_ICON_SIZE / 2) ?? const SizedBox(),
        value: BaseText('$assignee', color: canAssign ? null : f2Color, maxLines: 1),
        compact: compact,
        margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
        onTap: canAssign ? _tc.startAssign : null,
      );
    });
  }
}
