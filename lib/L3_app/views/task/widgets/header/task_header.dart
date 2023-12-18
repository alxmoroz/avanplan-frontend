// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this.controller);
  final TaskController controller;

  Task get _task => controller.task!;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_task.parent != null)
            MTField(
              controller.fData(TaskFCode.parent.index),
              value: BaseText(_task.parent!.title, maxLines: 1),
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: kIsWeb ? P : 0),
              color: Colors.transparent,
              minHeight: P4,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),
          MTField(
            controller.fData(TaskFCode.title.index),
            value: MTTextField(
              controller: controller.teController(TaskFCode.title.index),
              readOnly: !_task.canEdit,
              autofocus: controller.creating,
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
            padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: kIsWeb ? P : 0),
            color: Colors.transparent,
          ),
          const SizedBox(height: P),
        ],
      ),
    );
  }
}
