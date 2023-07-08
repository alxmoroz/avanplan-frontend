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
import '../../../usecases/task_ext_actions.dart';
import '../../../usecases/ws_ext_actions.dart';
import '../task_view_controller.dart';

class TaskPopupMenu extends StatelessWidget {
  const TaskPopupMenu(this.controller, {this.icon, this.child});
  final TaskViewController controller;
  final Widget? icon;
  final Widget? child;

  Task get _task => controller.task;

  Widget _tile({Widget? leading, String? title, Widget? trailing, Color? color}) => Row(children: [
        if (leading != null) ...[leading, const SizedBox(width: P_3)],
        title != null ? NormalText(title, color: color ?? mainColor) : const SizedBox(),
        if (trailing != null) ...[const SizedBox(width: P_3), trailing],
      ]);

  Widget _atWidget(TaskActionType at) {
    switch (at) {
      case TaskActionType.close:
        return _tile(leading: const DoneIcon(true), title: loc.close_action_title);
      case TaskActionType.reopen:
        return _tile(leading: const DoneIcon(false), title: loc.task_reopen_action_title);
      case TaskActionType.go2source:
        return _task.taskSource!.go2SourceTitle;
      case TaskActionType.unlink:
        return _tile(
          leading: const LinkBreakIcon(),
          title: loc.task_unlink_action_title,
          color: warningColor,
          trailing: _task.ws.plUnlink ? null : const RoubleCircleIcon(),
        );
      case TaskActionType.delete:
        return _tile(leading: const DeleteIcon(), title: loc.delete_action_title, color: dangerColor);
      default:
        return NormalText('$at');
    }
  }

  @override
  Widget build(BuildContext context) {
    return material(
      PopupMenuButton<TaskActionType>(
        icon: Padding(padding: const EdgeInsets.symmetric(horizontal: P), child: icon),
        itemBuilder: (_) => [for (final at in _task.actionTypes) PopupMenuItem<TaskActionType>(value: at, child: _atWidget(at))],
        onSelected: controller.taskAction,
        padding: EdgeInsets.zero,
        surfaceTintColor: lightBackgroundColor.resolve(context),
        color: lightBackgroundColor.resolve(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
      ),
    );
  }
}
