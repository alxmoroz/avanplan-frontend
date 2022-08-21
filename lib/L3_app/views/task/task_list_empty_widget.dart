// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/icons.dart';
import '../../components/mt_action.dart';
import '../../presenters/task_actions_presenter.dart';
import '../../presenters/task_level_presenter.dart';

class TaskListEmptyWidget extends StatelessWidget {
  const TaskListEmptyWidget(this.parent);
  final Task parent;

  @override
  Widget build(BuildContext context) {
    return MTFloatingAction(
      hint: parent.noSubtasksTitle,
      title: parent.newSubtaskTitle,
      icon: plusIcon(context, size: 24),
      onPressed: () => parent.addSubtask(context),
    );
  }
}
