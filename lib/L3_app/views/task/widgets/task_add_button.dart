// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_button.dart';
import '../../../components/mt_limit_badge.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';

class TaskAddButton extends StatelessWidget {
  const TaskAddButton(this.controller, {this.compact = false});
  final TaskViewController controller;
  final bool compact;

  Widget get _plusIcon => const PlusIcon();

  @override
  Widget build(BuildContext context) => MTLimitBadge(
        child: MTButton.outlined(
          color: backgroundColor,
          margin: const EdgeInsets.symmetric(horizontal: P).copyWith(left: controller.task.plCreate ? P : P2 + P_2),
          leading: compact ? null : _plusIcon,
          titleText: compact ? null : controller.task.newSubtaskTitle,
          middle: compact ? _plusIcon : null,
          constrained: !compact,
          onTap: () async => await controller.addSubtask(),
        ),
        showBadge: !controller.task.plCreate,
      );
}
