// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_actions.dart';
import '../../../../L1_domain/entities/task_ext_level.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/material_wrapper.dart';
import '../../../components/mt_button.dart';
import '../../../components/navbar.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_level_presenter.dart';

CupertinoNavigationBar taskNavBar(BuildContext context, Task task) {
  final _controller = taskViewController;

  Future<void> _action(TaskActionType? actionType) async {
    switch (actionType) {
      case TaskActionType.add:
        _controller.addTask(context);
        break;
      case TaskActionType.edit:
        _controller.editTask(context);
        break;
      case TaskActionType.import:
        await importController.importTasks(context);
        break;
      case TaskActionType.unlink:
        // TODO: Handle this case.
        break;
      case TaskActionType.unwatch:
        // TODO: Handle this case.
        break;
      case TaskActionType.go2source:
        break;
      case null:
    }
  }

  Widget itemWidget(TaskActionType at) =>
      {
        TaskActionType.add: plusIcon(context),
        TaskActionType.edit: editIcon(context),
        TaskActionType.import: importIcon(context),
        TaskActionType.go2source: const NormalText('go2source'),
        TaskActionType.unlink: const NormalText('unlink'),
        TaskActionType.unwatch: const NormalText('unwatch'),
      }[at] ??
      NormalText('$at');

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
