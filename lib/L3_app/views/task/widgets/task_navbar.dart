// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../main.dart';
import '../../../components/colors.dart';
import '../../../components/icons.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_colors_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../presenters/ws_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';
import 'task_popup_menu.dart';

CupertinoNavigationBar taskNavBar(TaskViewController controller) {
  final task = controller.task;

  return navBar(
    rootKey.currentContext!,
    bgColor: task.isRoot ? navbarDefaultBgColor : task.bgColor,
    middle: task.isRoot ? MediumText(loc.project_list_title) : task.ws.subPageTitle(task.viewTitle),
    trailing: !task.isRoot && task.actionTypes.isNotEmpty ? TaskPopupMenu(controller, icon: const MenuIcon()) : null,
  );
}
