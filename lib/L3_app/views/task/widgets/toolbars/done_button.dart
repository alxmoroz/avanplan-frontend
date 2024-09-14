// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/status.dart';

class TaskDoneButton extends StatefulWidget {
  const TaskDoneButton(this._controller, {super.key, this.size, this.onTap});
  final TaskController _controller;
  final double? size;
  final Function()? onTap;

  @override
  State<StatefulWidget> createState() => _TaskDoneButtonState();
}

class _TaskDoneButtonState extends State<TaskDoneButton> {
  TaskController get controller => widget._controller;
  Task get task => controller.task;

  bool hover = false;

  Future tap() async {
    if (task.parent?.closed == false || !task.closed) {
      await controller.setClosed(context, !task.closed);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTButton.icon(
      DoneIcon(
        task.closed,
        size: widget.size ?? P6,
        color: task.closed ? (hover ? mainColor : greenLightColor) : (hover ? greenColor : mainColor),
        solid: task.closed,
      ),
      padding: const EdgeInsets.symmetric(vertical: P),
      onHover: (h) => setState(() => hover = h),
      onTap: tap,
    );
  }
}
