// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/icons_workspace.dart';
import '../../../components/material_wrapper.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/source_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';

class TaskPopupMenu extends StatelessWidget {
  const TaskPopupMenu(this.controller, {this.icon, this.child, this.margin});
  final TaskViewController controller;
  final Widget? icon;
  final Widget? child;
  final EdgeInsets? margin;

  Task get _task => controller.task;

  Widget _tile({Widget? leading, String? title, Widget? trailing, Color? color}) => Row(children: [
        if (leading != null) ...[leading, const SizedBox(width: P_3)],
        title != null ? NormalText(title, color: color ?? mainColor) : const SizedBox(),
        if (trailing != null) ...[const SizedBox(width: P_3), trailing],
      ]);

  Widget _atWidget(Task task, TaskActionType at) {
    switch (at) {
      case TaskActionType.add:
        return _tile(leading: const PlusIcon(), title: task.newSubtaskTitle);
      case TaskActionType.edit:
        return _tile(leading: const EditIcon(), title: loc.task_edit_action_title);
      case TaskActionType.import_gitlab:
        return _tile(leading: const ImportIcon(), title: loc.import_menu_action_title, trailing: iconTitleForSourceType(refsController.stGitlab!));
      case TaskActionType.import_jira:
        return _tile(leading: const ImportIcon(), title: loc.import_menu_action_title, trailing: iconTitleForSourceType(refsController.stJira!));
      case TaskActionType.import_redmine:
        return _tile(leading: const ImportIcon(), title: loc.import_menu_action_title, trailing: iconTitleForSourceType(refsController.stRedmine!));
      case TaskActionType.close:
        return _tile(leading: const DoneIcon(true), title: loc.close_action_title);
      case TaskActionType.reopen:
        return _tile(leading: const DoneIcon(false), title: loc.task_reopen_action_title);
      case TaskActionType.go2source:
        return task.taskSource!.go2SourceTitle();
      case TaskActionType.unlink:
        return _tile(
          title: loc.task_unlink_action_title,
          color: warningColor,
          trailing: _task.plUnlink ? null : const RoubleCircleIcon(),
        );
      case TaskActionType.unwatch:
        return _tile(title: loc.task_unwatch_action_title, color: dangerColor);
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
          itemBuilder: (_) => [for (final at in _task.actionTypes) PopupMenuItem<TaskActionType>(value: at, child: _atWidget(_task, at))],
          onSelected: (at) => controller.taskAction(at),
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
        ),
      ),
    );
  }
}
