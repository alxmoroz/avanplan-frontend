// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_actions.dart';
import '../../../../L1_domain/entities/task_ext_level.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/material_wrapper.dart';
import '../../../components/mt_button.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../presenters/task_source_presenter.dart';

CupertinoNavigationBar taskNavBar(BuildContext context, Task task) {
  final _controller = taskViewController;

  Future<void> _action(TaskActionType? actionType) async {
    switch (actionType) {
      case TaskActionType.add:
        await _controller.addTask(context);
        break;
      case TaskActionType.edit:
        await _controller.editTask(context);
        break;
      case TaskActionType.import:
        await importController.importTasks(context);
        break;
      case TaskActionType.go2source:
        await launchUrl(task.taskSource!.uri);
        break;
      case TaskActionType.unlink:
        await _controller.unlinkTask(context);
        break;
      case TaskActionType.unwatch:
        await _controller.unwatchTask(context);
        break;
      case null:
    }
  }

  Widget rowIconTitle(String title, {Widget? icon, Color? color}) => Row(children: [
        if (icon != null) ...[
          icon,
          SizedBox(width: onePadding / 2),
        ],
        NormalText(title, color: color ?? mainColor),
      ]);

  Widget itemWidget(TaskActionType at) {
    Widget res = NormalText('$at');
    switch (at) {
      case TaskActionType.add:
        res = rowIconTitle(task.newSubtaskTitle, icon: plusIcon(context));
        break;
      case TaskActionType.edit:
        res = rowIconTitle(loc.task_edit_action_title, icon: editIcon(context));
        break;
      case TaskActionType.import:
        res = rowIconTitle(loc.task_import_action_title, icon: importIcon(context));
        break;
      case TaskActionType.go2source:
        res = task.taskSource!.go2SourceTitle(context);
        break;
      case TaskActionType.unlink:
        res = rowIconTitle(loc.task_unlink_action_title, color: warningColor);
        break;
      case TaskActionType.unwatch:
        res = rowIconTitle(loc.task_unwatch_action_title, color: dangerColor);
        break;
    }
    return res;
  }

  return navBar(
    context,
    leading: task.canRefresh
        ? Row(children: [
            SizedBox(width: onePadding),
            MTButton.icon(refreshIcon(context), mainController.updateAll),
          ])
        : null,
    title: task.isWorkspace ? loc.project_list_title : task.viewTitle,
    trailing: material(
      PopupMenuButton<TaskActionType>(
        icon: menuIcon(context),
        itemBuilder: (_) => task.actionTypes.map((at) => PopupMenuItem<TaskActionType>(value: at, child: itemWidget(at))).toList(),
        onSelected: _action,
        padding: EdgeInsets.symmetric(horizontal: onePadding / 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(onePadding / 2)),
      ),
    ),
  );
}
