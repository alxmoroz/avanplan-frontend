// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task_ext_actions.dart';
import '../../../../L1_domain/entities/task_ext_level.dart';
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

CupertinoNavigationBar taskNavBar(BuildContext context, TaskViewController controller) {
  final task = controller.task;

  Widget rowIconTitle(String title, {Widget? icon, Color? color}) => Row(children: [
        if (icon != null) ...[
          icon,
          SizedBox(width: onePadding / 2),
        ],
        NormalText(title, color: color ?? mainColor),
      ]);

  Widget itemWidget(TaskActionType at) {
    switch (at) {
      case TaskActionType.add:
        return rowIconTitle(task.newSubtaskTitle, icon: plusIcon(context));
      case TaskActionType.edit:
        return rowIconTitle(loc.task_edit_action_title, icon: editIcon(context));
      case TaskActionType.import:
        return rowIconTitle(loc.task_import_action_title, icon: importIcon(context));
      case TaskActionType.go2source:
        return task.taskSource!.go2SourceTitle(context);
      case TaskActionType.unlink:
        return rowIconTitle(loc.task_unlink_action_title, color: warningColor);
      case TaskActionType.unwatch:
        return rowIconTitle(loc.task_unwatch_action_title, color: dangerColor);
      default:
        return NormalText('$at');
    }
  }

  return navBar(
    context,
    // leading: task.canRefresh
    //     ? Row(children: [
    //         SizedBox(width: onePadding),
    //         MTButton.icon(refreshIcon(context), mainController.updateAll),
    //       ])
    //     : null,
    title: task.isWorkspace ? loc.project_list_title : task.viewTitle,
    trailing: task.actionTypes.isNotEmpty
        ? material(
            PopupMenuButton<TaskActionType>(
              icon: menuIcon(),
              itemBuilder: (_) => task.actionTypes.map((at) => PopupMenuItem<TaskActionType>(value: at, child: itemWidget(at))).toList(),
              onSelected: (at) => controller.taskAction(at, context),
              padding: EdgeInsets.symmetric(horizontal: onePadding / 2),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(onePadding / 2)),
            ),
          )
        : null,
  );
}
