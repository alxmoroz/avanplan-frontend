// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../theme/colors.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/status.dart';

class TaskDoneButton extends StatefulWidget {
  const TaskDoneButton(this._tc, {super.key, this.onTap});
  final TaskController _tc;
  final Function()? onTap;

  @override
  State<StatefulWidget> createState() => _TaskDoneButtonState();
}

class _TaskDoneButtonState extends State<TaskDoneButton> {
  TaskController get _tc => widget._tc;
  Task get _t => _tc.task;

  bool hover = false;

  Future _tap() async {
    if (_t.parent?.closed == false || !_t.closed) {
      await _tc.setClosed(!_t.closed, canPop: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTButton.icon(
      DoneIcon(
        _t.closed,
        size: DEF_TAPPABLE_ICON_SIZE,
        color: !_tc.canEdit
            ? f3Color
            : _t.closed
                ? (hover ? mainColor : greenLightColor)
                : (hover ? greenColor : mainColor),
        solid: _t.closed,
      ),
      padding: const EdgeInsets.symmetric(vertical: (P8 - DEF_TAPPABLE_ICON_SIZE) / 2),
      onHover: _tc.canEdit ? (h) => setState(() => hover = h) : null,
      onTap: _tc.canEdit ? _tap : null,
    );
  }
}
