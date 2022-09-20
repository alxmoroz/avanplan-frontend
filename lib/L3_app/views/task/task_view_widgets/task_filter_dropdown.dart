// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../task_view_controller.dart';

class TaskFilterDropdown extends StatelessWidget {
  const TaskFilterDropdown(this.controller);
  final TaskViewController controller;

  List<DropdownMenuItem<TaskFilter>> get ddItems => controller.taskFilterKeys
      .map(
        (item) => DropdownMenuItem<TaskFilter>(
          value: item,
          child: NormalText(controller.task.taskFilterText(item), padding: EdgeInsets.only(right: onePadding / 2)),
        ),
      )
      .toList();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        DropdownButton<TaskFilter>(
          items: ddItems,
          value: controller.tasksFilter,
          icon: dropdownCaretIcon(context),
          underline: Container(),
          onChanged: (type) => controller.setFilter(type),
          borderRadius: BorderRadius.circular(onePadding / 2),
        ),
        SizedBox(width: onePadding),
      ],
    );
  }
}
