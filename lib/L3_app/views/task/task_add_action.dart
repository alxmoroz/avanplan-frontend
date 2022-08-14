// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/icons.dart';
import '../../components/mt_action.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';

class TaskAddAction extends StatelessWidget {
  const TaskAddAction(this.parent);

  final Task parent;

  @override
  Widget build(BuildContext context) {
    return MTAction(
      hint: parent.noSubtasksTitle,
      title: parent.newSubtaskTitle,
      icon: plusIcon(context, size: 24),
      onPressed: () => taskViewController.addTask(context),
    );
  }
}
