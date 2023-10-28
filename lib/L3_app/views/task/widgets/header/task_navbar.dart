// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/appbar.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_type.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/workspace.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'task_popup_menu.dart';

AppBar taskAppBar(BuildContext context, TaskController controller) {
  final task = controller.task;

  return MTAppBar(
    context,
    bgColor: task.bgColor,
    middle: task.ws.subPageTitle(task.viewTitle),
    trailing: task.loading != true && task.actionTypes.isNotEmpty ? TaskPopupMenu(controller, icon: const MenuIcon()) : const SizedBox(width: P8),
  );
}
