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
import '../../../../presenters/task_view.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import 'header_dashboard.dart';

class TaskHeader extends StatelessWidget {
  const TaskHeader(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Название родителя
          if (_task.parent != null)
            MTField(
              _controller.fData(TaskFCode.parent.index),
              value: BaseText(_task.parent!.title, maxLines: 1),
              padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: kIsWeb ? P : 0),
              color: Colors.transparent,
              minHeight: P4,
              crossAxisAlignment: CrossAxisAlignment.center,
            ),

          /// Название
          MTField(
            _controller.fData(TaskFCode.title.index),
            value: MTTextField(
              controller: _controller.teController(TaskFCode.title.index),
              readOnly: !_task.canEdit,
              autofocus: _controller.creating,
              margin: EdgeInsets.zero,
              maxLines: 5,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: _controller.titleController.titlePlaceholder,
                hintStyle: const H1('', color: f3Color).style(context),
              ),
              style: const H1('').style(context),
              onChanged: _controller.titleController.editTitle,
            ),
            padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: kIsWeb ? P : 0),
            color: Colors.transparent,
          ),

          /// Дашборд (аналитика, команда)
          if (_task.hasAnalytics || _task.hasTeam) TaskHeaderDashboard(_controller),
        ],
      ),
    );
  }
}
