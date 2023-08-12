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
import '../../../usecases/task_available_actions.dart';
import '../../../usecases/task_link.dart';
import '../../../usecases/ws_available_actions.dart';
import '../controllers/delete_controller.dart';
import '../controllers/task_controller.dart';

class TaskPopupMenu extends StatelessWidget {
  const TaskPopupMenu(this.controller, {this.icon, this.child});
  final TaskController controller;
  final Widget? icon;
  final Widget? child;

  Task get _task => controller.task;

  bool _enabled(TaskActionType at) {
    return at != TaskActionType.localExport || !controller.fData(TaskFCode.parent.index).loading;
  }

  Widget _tile(TaskActionType at, {Widget? leading, String? title, Widget? trailing, Color? color}) => Row(children: [
        if (leading != null) ...[leading, const SizedBox(width: P_3)],
        title != null ? NormalText(title, color: (color ?? mainColor).withAlpha(_enabled(at) ? 255 : 110)) : const SizedBox(),
        if (trailing != null) ...[const SizedBox(width: P_3), trailing],
      ]);

  Widget _atWidget(TaskActionType at) {
    switch (at) {
      case TaskActionType.close:
        return _tile(at, leading: const DoneIcon(true, color: greenColor), title: loc.close_action_title, color: greenColor);
      case TaskActionType.reopen:
        return _tile(at, leading: const DoneIcon(false), title: loc.task_reopen_action_title);
      case TaskActionType.localExport:
        return _tile(at, leading: const LocalExportIcon(), title: loc.task_transfer_export_action_title);
      case TaskActionType.go2source:
        return _task.go2SourceTitle;
      case TaskActionType.unlink:
        return _tile(
          at,
          leading: const LinkBreakIcon(),
          title: loc.task_unlink_action_title,
          color: warningColor,
          trailing: _task.ws.plUnlink ? null : const RoubleCircleIcon(),
        );
      case TaskActionType.delete:
        return _tile(at, leading: const DeleteIcon(), title: loc.delete_action_title, color: dangerColor);
      default:
        return NormalText('$at');
    }
  }

  Future _taskAction(TaskActionType? actionType) async {
    switch (actionType) {
      case TaskActionType.close:
        await controller.statusController.setStatus(_task, close: true);
        break;
      case TaskActionType.reopen:
        await controller.statusController.setStatus(_task, close: false);
        break;
      case TaskActionType.localExport:
        await controller.transferController.localExport();
        break;
      case TaskActionType.go2source:
        await _task.go2source();
        break;
      case TaskActionType.unlink:
        await _task.unlink();
        break;
      case TaskActionType.delete:
        await DeleteController().delete(_task);
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return material(
      PopupMenuButton<TaskActionType>(
        icon: Padding(padding: const EdgeInsets.symmetric(horizontal: P), child: icon),
        itemBuilder: (_) => [
          for (final at in _task.actionTypes)
            PopupMenuItem<TaskActionType>(
              value: at,
              child: _atWidget(at),
              enabled: _enabled(at),
            )
        ],
        onSelected: _taskAction,
        padding: EdgeInsets.zero,
        surfaceTintColor: lightBackgroundColor.resolve(context),
        color: lightBackgroundColor.resolve(context),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(DEF_BORDER_RADIUS)),
      ),
    );
  }
}
