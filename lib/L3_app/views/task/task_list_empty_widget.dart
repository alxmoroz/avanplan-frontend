// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/icons.dart';
import '../../components/mt_action.dart';
import '../../presenters/task_level_presenter.dart';
import 'task_view_controller.dart';

class TaskListEmptyWidget extends StatelessWidget {
  const TaskListEmptyWidget(this.controller);
  final TaskViewController controller;

  @override
  Widget build(BuildContext context) {
    return MTFloatingAction(
      hint: controller.task.noSubtasksTitle,
      title: controller.task.newSubtaskTitle,
      icon: plusIcon(context, size: 24),
      onPressed: () => controller.addSubtask(context),
    );
  }
}
