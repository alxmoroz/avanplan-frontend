// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities/task_ext_actions.dart';
import '../../L1_domain/entities/task_ext_level.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/icons.dart';
import '../components/material_wrapper.dart';
import '../components/mt_button.dart';
import '../components/navbar.dart';
import '../components/text_widgets.dart';
import '../extra/services.dart';
import '../presenters/task_actions_presenter.dart';
import '../presenters/task_level_presenter.dart';
import 'task_source_presenter.dart';

extension TaskNavBarPresenter on Task {
  CupertinoNavigationBar taskNavBar(BuildContext context) {
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
          res = rowIconTitle(newSubtaskTitle, icon: plusIcon(context));
          break;
        case TaskActionType.edit:
          res = rowIconTitle(loc.task_edit_action_title, icon: editIcon(context));
          break;
        case TaskActionType.import:
          res = rowIconTitle(loc.task_import_action_title, icon: importIcon(context));
          break;
        case TaskActionType.go2source:
          res = taskSource!.go2SourceTitle(context);
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
      leading: canRefresh
          ? Row(children: [
              SizedBox(width: onePadding),
              MTButton.icon(refreshIcon(context), mainController.updateAll),
            ])
          : null,
      title: isWorkspace ? loc.project_list_title : viewTitle,
      trailing: actionTypes.isNotEmpty
          ? material(
              PopupMenuButton<TaskActionType>(
                icon: menuIcon(context),
                itemBuilder: (_) => actionTypes.map((at) => PopupMenuItem<TaskActionType>(value: at, child: itemWidget(at))).toList(),
                onSelected: (at) => taskAction(at, context),
                padding: EdgeInsets.symmetric(horizontal: onePadding / 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(onePadding / 2)),
              ),
            )
          : null,
    );
  }
}
