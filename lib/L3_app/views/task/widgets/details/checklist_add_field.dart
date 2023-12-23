// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/field_data.dart';
import '../../../../components/icons.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';

class TaskChecklistAddField extends StatelessWidget {
  const TaskChecklistAddField(this._controller);
  final TaskController _controller;

  @override
  Widget build(BuildContext context) {
    return MTField(
      MTFieldData(-1, placeholder: '${loc.action_add_title} ${loc.checklist.toLowerCase()}'),
      margin: const EdgeInsets.only(top: P3),
      leading: const PlusIcon(color: mainColor, size: P5, circled: true),
      onTap: () async => await _controller.subtasksController.addTask(),
    );
  }
}
