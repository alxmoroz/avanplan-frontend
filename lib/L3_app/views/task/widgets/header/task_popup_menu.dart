// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/material_wrapper.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../toolbar/action_item.dart';

class TaskPopupMenu extends StatelessWidget with FocusManaging {
  const TaskPopupMenu(this.controller, {this.icon, this.child});
  final TaskController controller;
  final Widget? icon;
  final Widget? child;

  Task get _task => controller.task!;

  @override
  Widget build(BuildContext context) {
    return material(
      PopupMenuButton<TaskActionType>(
        icon: Padding(padding: const EdgeInsets.symmetric(horizontal: P2), child: icon),
        itemBuilder: (_) => [for (final at in _task.actionTypes) PopupMenuItem<TaskActionType>(value: at, child: TaskActionItem(at))],
        onOpened: () => unfocus(context),
        onSelected: controller.taskAction,
        padding: EdgeInsets.zero,
        surfaceTintColor: b3Color.resolve(context),
        color: b3Color.resolve(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
      ),
    );
  }
}
