// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../components/colors.dart';
import '../../../components/icons.dart';
import '../../../components/navbar.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';
import 'task_popup_menu.dart';

CupertinoNavigationBar taskNavBar(BuildContext context, TaskViewController controller) {
  final task = controller.task;

  return navBar(
    context,
    bgColor: task.isWorkspace ? navbarDefaultBgColor : backgroundColor,
    title: task.isWorkspace ? loc.project_list_title : task.viewTitle,
    trailing: !task.isWorkspace && task.actionTypes.isNotEmpty ? TaskPopupMenu(controller, icon: const MenuIcon()) : null,
  );
}
