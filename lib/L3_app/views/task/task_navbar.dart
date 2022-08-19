// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_actions.dart';
import '../../../L1_domain/entities/task_ext_level.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';

CupertinoNavigationBar taskNavBar(BuildContext context, Task task) {
  final _controller = taskViewController;

  return navBar(
    context,
    title: task.isWorkspace ? loc.project_list_title : task.viewTitle,
    leading: task.canRefresh
        ? Row(children: [
            SizedBox(width: onePadding),
            MTButton.icon(refreshIcon(context), mainController.updateAll),
          ])
        : null,
    trailing: Row(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
      if (task.canImport) ...[
        MTButton.icon(importIcon(context), () => importController.importTasks(context)),
        SizedBox(width: onePadding),
      ],
      if (task.canAdd) ...[
        MTButton.icon(plusIcon(context), () => _controller.addTask(context)),
        SizedBox(width: onePadding),
      ],
      if (task.canEdit) ...[
        MTButton.icon(editIcon(context), () => _controller.editTask(context)),
        SizedBox(width: onePadding),
      ],
    ]),
  );
}
