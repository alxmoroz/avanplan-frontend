// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../main.dart';
import '../../../components/icons.dart';
import '../../../components/navbar.dart';
import '../../../presenters/task_colors_presenter.dart';
import '../../../presenters/task_type_presenter.dart';
import '../../../presenters/ws_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';
import 'task_popup_menu.dart';

CupertinoNavigationBar taskNavBar(TaskViewController controller) {
  final task = controller.task;

  return navBar(
    rootKey.currentContext!,
    bgColor: task.bgColor,
    middle: task.ws.subPageTitle(task.viewTitle),
    trailing: task.actionTypes.isNotEmpty ? TaskPopupMenu(controller, icon: const MenuIcon()) : null,
  );
}
