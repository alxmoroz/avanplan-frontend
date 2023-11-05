// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../presenters/task_view.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.controller);
  final TaskController controller;

  Task get _task => controller.task;

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_task.parent != null)
                MTField(
                  controller.fData(TaskFCode.parent.index),
                  value: BaseText(_task.parent!.title, maxLines: 2),
                  padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: isWeb ? P : P_2),
                  color: b2Color,
                  minHeight: P5,
                  crossAxisAlignment: CrossAxisAlignment.center,
                ),
              MTField(
                controller.fData(TaskFCode.title.index),
                value: MTTextField(
                  controller: controller.teController(TaskFCode.title.index),
                  readOnly: !_task.canEdit,
                  autofocus: _task.isNew,
                  margin: EdgeInsets.zero,
                  maxLines: 5,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    hintText: controller.titleController.titlePlaceholder,
                    hintStyle: const H1('', color: f3Color).style(context),
                  ),
                  style: const H1('').style(context),
                  onChanged: controller.titleController.editTitle,
                ),
                padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: isWeb ? P2 : P_2),
                color: b2Color,
              ),
              const SizedBox(height: P),
            ],
          ),
        ),
      ),
    );
  }
}
