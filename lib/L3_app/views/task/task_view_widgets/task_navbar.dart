// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_actions.dart';
import '../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/material_wrapper.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/source_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../task_view_controller.dart';

class TaskPopupMenu extends StatelessWidget {
  const TaskPopupMenu(this.controller, {this.icon, this.child, this.margin});
  final TaskViewController controller;
  final Widget? icon;
  final Widget? child;
  final EdgeInsets? margin;

  Task get _task => controller.task;

  Widget rowIconTitle(String title, {Widget? icon, Color? color}) => Row(children: [
        if (icon != null) ...[
          icon,
          const SizedBox(width: P_3),
        ],
        NormalText(title, color: color ?? mainColor),
      ]);

  Widget itemWidget(Task task, TaskActionType at) {
    switch (at) {
      case TaskActionType.add:
        return rowIconTitle(task.newSubtaskTitle, icon: const PlusIcon());
      case TaskActionType.edit:
        return rowIconTitle(loc.task_edit_action_title, icon: const EditIcon());
      case TaskActionType.import:
        return rowIconTitle(loc.import_action_title, icon: const ImportIcon());
      case TaskActionType.close:
        return rowIconTitle(loc.close_action_title, icon: const DoneIcon(true));
      case TaskActionType.reopen:
        return rowIconTitle(loc.task_reopen_action_title, icon: const DoneIcon(false));
      case TaskActionType.go2source:
        return task.taskSource!.go2SourceTitle();
      case TaskActionType.unlink:
        return rowIconTitle(loc.task_unlink_action_title, color: warningColor);
      case TaskActionType.unwatch:
        return rowIconTitle(loc.task_unwatch_action_title, color: dangerColor);
      default:
        return NormalText('$at');
    }
  }

  @override
  Widget build(BuildContext context) {
    return material(
      Padding(
        padding: margin ?? EdgeInsets.zero,
        child: PopupMenuButton<TaskActionType>(
          child: child,
          icon: icon,
          itemBuilder: (_) => [for (final at in _task.actionTypes) PopupMenuItem<TaskActionType>(value: at, child: itemWidget(_task, at))],
          onSelected: (at) => controller.taskAction(at, context),
          padding: const EdgeInsets.symmetric(horizontal: P_2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
        ),
      ),
    );
  }
}

CupertinoNavigationBar taskNavBar(BuildContext context, TaskViewController controller) {
  final task = controller.task;

  return navBar(
    context,
    bgColor: task.isWorkspace ? navbarDefaultBgColor : backgroundColor,
    title: task.isWorkspace ? loc.project_list_title : task.viewTitle,
    trailing: !task.isWorkspace && task.actionTypes.isNotEmpty ? TaskPopupMenu(controller, icon: const MenuIcon()) : null,
  );
}

class TaskFloatingPlusButton extends StatelessWidget {
  const TaskFloatingPlusButton({required this.controller});

  final TaskViewController controller;

  @override
  Widget build(BuildContext context) => TaskPopupMenu(
        controller,
        margin: const EdgeInsets.only(right: P),
        child: Container(
          width: MIN_BTN_HEIGHT,
          height: MIN_BTN_HEIGHT,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS),
            border: Border.fromBorderSide(BorderSide(color: mainColor.resolve(context), width: DEF_BORDER_WIDTH)),
          ),
          child: const PlusIcon(),
        ),
      );
}
