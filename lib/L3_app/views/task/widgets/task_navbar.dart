// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../main.dart';
import '../../../components/icons.dart';
import '../../../components/navbar.dart';
import '../../../presenters/task_type.dart';
import '../../../presenters/task_view.dart';
import '../../../presenters/workspace.dart';
import '../../../usecases/task_available_actions.dart';
import '../controllers/task_controller.dart';
import 'task_popup_menu.dart';

CupertinoNavigationBar taskNavBar(TaskController controller) {
  final task = controller.task;

  return navBar(
    rootKey.currentContext!,
    bgColor: task.bgColor,
    middle: task.ws.subPageTitle(controller.isNew ? '' : task.viewTitle),
    trailing: task.actionTypes.isNotEmpty ? TaskPopupMenu(controller, icon: const MenuIcon()) : null,
  );
}
