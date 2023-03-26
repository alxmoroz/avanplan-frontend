// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_menu_shape.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';
import 'task_add_button.dart';
import 'task_popup_menu.dart';

class TaskAddMenu extends StatelessWidget {
  const TaskAddMenu(this.controller);

  final TaskViewController controller;

  @override
  Widget build(BuildContext context) => controller.task.plCreate
      ? TaskPopupMenu(
          controller,
          margin: const EdgeInsets.symmetric(horizontal: P),
          child: const MTMenuShape(icon: PlusIcon()),
        )
      : TaskAddButton(controller, compact: true);
}
