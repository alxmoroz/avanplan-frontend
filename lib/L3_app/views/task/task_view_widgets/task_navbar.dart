// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/material_wrapper.dart';
import '../../../components/mt_menu_plus_shape.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/source_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../task_ext_actions.dart';
import '../task_view_controller.dart';

class _TaskPopupMenu extends StatelessWidget {
  const _TaskPopupMenu(this.controller, {this.icon, this.child, this.margin});
  final TaskViewController controller;
  final Widget? icon;
  final Widget? child;
  final EdgeInsets? margin;

  Task get _task => controller.task;

  Widget tile({Widget? leading, String? title, Widget? trailing, Color? color}) => Row(children: [
        if (leading != null) ...[leading, const SizedBox(width: P_3)],
        title != null ? NormalText(title, color: color ?? mainColor) : const SizedBox(),
        if (trailing != null) ...[const SizedBox(width: P_3), trailing],
      ]);

  Widget itemWidget(Task task, TaskActionType at) {
    switch (at) {
      case TaskActionType.add:
        return tile(leading: const PlusIcon(), title: task.newSubtaskTitle);
      case TaskActionType.edit:
        return tile(leading: const EditIcon(), title: loc.task_edit_action_title);
      case TaskActionType.import_gitlab:
        return tile(leading: const ImportIcon(), title: loc.import_title, trailing: referencesController.stGitlab!.iconTitle);
      case TaskActionType.import_jira:
        return tile(leading: const ImportIcon(), title: loc.import_title, trailing: referencesController.stJira!.iconTitle);
      case TaskActionType.import_redmine:
        return tile(leading: const ImportIcon(), title: loc.import_title, trailing: referencesController.stRedmine!.iconTitle);
      case TaskActionType.close:
        return tile(leading: const DoneIcon(true), title: loc.close_action_title);
      case TaskActionType.reopen:
        return tile(leading: const DoneIcon(false), title: loc.task_reopen_action_title);
      case TaskActionType.go2source:
        return task.taskSource!.go2SourceTitle();
      case TaskActionType.unlink:
        return tile(title: loc.task_unlink_action_title, color: warningColor);
      case TaskActionType.unwatch:
        return tile(title: loc.task_unwatch_action_title, color: dangerColor);
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
          padding: EdgeInsets.zero,
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
    trailing: !task.isWorkspace && task.actionTypes.isNotEmpty && controller.canEditTask ? _TaskPopupMenu(controller, icon: const MenuIcon()) : null,
  );
}

class TaskAddMenu extends StatelessWidget {
  const TaskAddMenu(this.controller);

  final TaskViewController controller;

  @override
  Widget build(BuildContext context) => _TaskPopupMenu(
        controller,
        margin: const EdgeInsets.only(right: P),
        child: const MTMenuShape(icon: PlusIcon()),
      );
}
