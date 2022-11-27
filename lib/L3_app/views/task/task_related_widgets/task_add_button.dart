// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_button.dart';
import '../../../presenters/task_level_presenter.dart';
import '../task_view_controller.dart';

class TaskAddButton extends StatelessWidget {
  const TaskAddButton(this.controller);
  final TaskViewController controller;

  @override
  Widget build(BuildContext context) => MTButton.outlined(
        margin: const EdgeInsets.symmetric(horizontal: P),
        leading: const PlusIcon(),
        titleText: controller.task.newSubtaskTitle,
        onTap: () async => await controller.addSubtask(context),
      );
}
