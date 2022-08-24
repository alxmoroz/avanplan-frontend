// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../task/task_add_action_widget.dart';
import '../task/task_view_controller.dart';

class ProjectEmptyListActionsWidget extends StatelessWidget {
  const ProjectEmptyListActionsWidget({required this.taskController, required this.parentContext});
  final TaskViewController taskController;
  final BuildContext parentContext;

  @override
  Widget build(BuildContext context) {
    return ListView(shrinkWrap: true, children: [
      TaskAddActionWidget(
        taskController,
        parentContext: parentContext,
      ),
    ]);
  }
}
