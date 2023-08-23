// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../components/colors.dart';
import '../../../components/colors_base.dart';
import '../../../components/constants.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_field.dart';
import '../../../components/mt_text_field.dart';
import '../../../components/text_widgets.dart';
import '../../../presenters/task_tree.dart';
import '../../../presenters/task_view.dart';
import '../../../usecases/task_available_actions.dart';
import '../controllers/task_controller.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.controller);
  final TaskController controller;

  Task get _task => controller.task;

  @override
  Widget build(BuildContext context) {
    final _titlePlaceholder = controller.titleController.titlePlaceholder;
    return Observer(
      builder: (_) => MTAdaptive(
        force: true,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [_task.bgColor.resolve(context), b2Color.resolve(context)],
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: P),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_task.parent != null)
                MTField(
                  controller.fData(TaskFCode.parent.index),
                  value: NormalText(_task.parent!.title),
                  padding: const EdgeInsets.symmetric(vertical: P_2),
                  color: b2Color,
                ),
              MTField(
                controller.fData(TaskFCode.title.index),
                value: MTTextField(
                  controller: controller.teController(TaskFCode.title.index),
                  readOnly: !_task.canUpdate,
                  autofocus: controller.isNew,
                  margin: EdgeInsets.zero,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: _titlePlaceholder,
                    hintStyle: const H1('', color: f3Color).style(context),
                  ),
                  style: const H1('').style(context),
                  onChanged: controller.titleController.editTitle,
                ),
                padding: EdgeInsets.zero,
                color: b2Color,
              ),
              const SizedBox(height: P_2),
            ],
          ),
        ),
      ),
    );
  }
}
