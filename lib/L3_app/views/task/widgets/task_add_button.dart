// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../main.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_limit_badge.dart';
import '../../../presenters/task_level_presenter.dart';
import '../task_view_controller.dart';

class TaskAddButton extends StatelessWidget {
  const TaskAddButton(this.controller, {this.compact = false, this.dismissible = false});
  final TaskViewController controller;
  final bool compact;
  final bool dismissible;

  Widget get _plusIcon => const PlusIcon();

  Future _tap() async {
    if (dismissible) {
      Navigator.of(rootKey.currentContext!).pop();
    }
    await controller.addSubtask();
  }

  @override
  Widget build(BuildContext context) => MTLimitBadge(
        child: MTButton.outlined(
          leading: compact ? null : _plusIcon,
          titleText: compact ? null : controller.task.newSubtaskTitle,
          middle: compact ? _plusIcon : null,
          constrained: !compact,
          onTap: _tap,
          margin: EdgeInsets.only(right: compact ? P : 0),
        ),
        showBadge: !controller.plCreate,
        constrained: !compact,
      );
}
