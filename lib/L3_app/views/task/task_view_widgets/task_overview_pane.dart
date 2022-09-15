// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_actions.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_rich_button.dart';
import '../../../extra/services.dart';
import '../task_add_action_widget.dart';
import '../task_view_controller.dart';
import 'task_overview_advices.dart';
import 'task_overview_warnings.dart';
import 'task_state_indicator.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview(this.controller);
  final TaskViewController controller;
  Task get task => controller.task;

  bool get hasAuthor => task.author != null;

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      if (!task.closed) ...[
        SizedBox(height: onePadding),
        TaskStateIndicator(task),
      ],
      if (controller.mayAddSubtask) TaskAddActionWidget(controller, parentContext: context),
      if (task.canEdit && (task.isClosable || task.closed)) ...[
        MTRichButton(
          hint: task.isClosable ? loc.task_state_closable_hint : '',
          title: task.isClosable ? loc.task_state_close_btn_title : loc.task_state_reopen_btn_title,
          icon: task.isClosable ? doneIcon(context, true) : null,
          onTap: () => controller.setClosed(context, !task.closed),
        ),
      ],
      if (task.hasOverdueTasks || task.hasRiskTasks) TaskOverviewWarnings(task) else TaskOverviewAdvices(task),
    ]);
  }
}
