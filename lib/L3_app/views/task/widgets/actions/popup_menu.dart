// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/material_wrapper.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'action_item.dart';

class TaskPopupMenu extends StatelessWidget with FocusManaging {
  const TaskPopupMenu(this.controller, {super.key});
  final TaskController controller;

  Task get _task => controller.task!;

  @override
  Widget build(BuildContext context) {
    return material(
      PopupMenuButton<TaskAction>(
        icon: const Padding(padding: EdgeInsets.symmetric(horizontal: P2), child: MenuIcon()),
        itemBuilder: (_) => [for (final at in _task.actions(context)) PopupMenuItem<TaskAction>(value: at, child: TaskActionItem(at))],
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
