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
import '../../../presenters/task_level_presenter.dart';
import '../../../presenters/task_source_presenter.dart';
import '../task_view_controller.dart';

class TaskPopupMenu extends StatelessWidget {
  const TaskPopupMenu(this.controller, {this.icon, this.child, this.margin, required this.parentContext});
  final TaskViewController controller;
  final BuildContext parentContext;
  final Widget? icon;
  final Widget? child;
  final EdgeInsets? margin;

  Task get task => controller.task;

  Widget rowIconTitle(String title, {Widget? icon, Color? color}) => Row(children: [
        if (icon != null) ...[
          icon,
          SizedBox(width: onePadding / 3),
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
          itemBuilder: (_) => task.actionTypes.map((at) => PopupMenuItem<TaskActionType>(value: at, child: itemWidget(task, at))).toList(),
          onSelected: (at) => controller.taskAction(at, parentContext),
          padding: EdgeInsets.symmetric(horizontal: onePadding / 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultBorderRadius)),
        ),
      ),
    );
  }
}

CupertinoNavigationBar taskNavBar(BuildContext context, TaskViewController controller) {
  final task = controller.task;

  return navBar(
    context,
    // leading: task.canRefresh
    //     ? Row(children: [
    //         SizedBox(width: onePadding),
    //         MTButton.icon(refreshIcon(context), mainController.updateAll),
    //       ])
    //     : null,
    bgColor: task.isWorkspace ? navbarDefaultBgColor : backgroundColor,
    title: task.isWorkspace ? loc.project_list_title : task.viewTitle,
    trailing: !task.isWorkspace && task.actionTypes.isNotEmpty ? TaskPopupMenu(controller, icon: const MenuIcon(), parentContext: context) : null,
  );
}

class TaskFloatingPlusButton extends StatelessWidget {
  const TaskFloatingPlusButton({required this.controller, required this.parentContext});

  final TaskViewController controller;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return TaskPopupMenu(
      controller,
      parentContext: parentContext,
      margin: EdgeInsets.only(right: onePadding),
      child: Container(
        padding: EdgeInsets.all(onePadding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultBorderRadius),
          border: Border.fromBorderSide(BorderSide(color: mainColor.resolve(context), width: 2)),
        ),
        child: const PlusIcon(),
      ),
    );
  }
}
