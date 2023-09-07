// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../main.dart';
import '../../../../components/appbar.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_type.dart';
import '../../../../presenters/task_view.dart';
import '../../../../presenters/workspace.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'task_popup_menu.dart';

AppBar taskNavBar(TaskController controller) {
  final task = controller.task;

  return appBar(
    rootKey.currentContext!,
    bgColor: task.bgColor,
    middle: task.ws.subPageTitle(task.viewTitle),
    trailing: task.actionTypes.isNotEmpty ? TaskPopupMenu(controller, icon: const MenuIcon()) : null,
  );
}
