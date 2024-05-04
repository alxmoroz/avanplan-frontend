// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../components/text_field.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import 'parent_title.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Хлебная крошка - Название родителя
          if (_task.parent != null) TaskParentTitle(_controller),

          /// Название
          MTField(
            _controller.fData(TaskFCode.title.index),
            leading: _task.isInbox ? const InboxIcon(color: f2Color) : null,
            value: MTTextField(
              controller: _controller.teController(TaskFCode.title.index),
              readOnly: !_task.canEdit,
              autofocus: _task.creating,
              margin: EdgeInsets.zero,
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: _controller.titleController.titlePlaceholder,
                hintStyle: const H1('', color: f3Color, maxLines: 5).style(context),
              ),
              style: H1('', color: _task.isInbox ? f2Color : null, maxLines: 5).style(context),
              onChanged: _controller.titleController.editTitle,
            ),
            padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: isWeb ? P : 0),
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
