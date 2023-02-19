// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_menu_shape.dart';
import '../task_view_controller.dart';
import 'task_popup_menu.dart';

class TaskAddMenu extends StatelessWidget {
  const TaskAddMenu(this.controller);

  final TaskViewController controller;

  @override
  Widget build(BuildContext context) => TaskPopupMenu(
        controller,
        margin: const EdgeInsets.only(right: P),
        child: const MTMenuShape(icon: PlusIcon()),
      );
}
