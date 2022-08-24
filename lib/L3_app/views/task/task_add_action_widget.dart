// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/icons.dart';
import '../../components/mt_action.dart';
import '../../presenters/task_level_presenter.dart';
import 'task_view_controller.dart';

class TaskAddActionWidget extends StatelessWidget {
  const TaskAddActionWidget(this.controller, {required this.parentContext});
  final TaskViewController controller;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return MTFloatingAction(
      title: controller.task.newSubtaskTitle,
      icon: plusIcon(context, size: 24),
      onPressed: () async => await controller.addSubtask(parentContext),
    );
  }
}
