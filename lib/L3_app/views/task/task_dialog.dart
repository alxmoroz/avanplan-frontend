// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/dialog.dart';
import '../../components/list_tile.dart';
import '../../components/toolbar.dart';
import '../../usecases/task_actions.dart';
import 'controllers/task_controller.dart';
import 'widgets/details/assignee_field.dart';
import 'widgets/details/due_date_field.dart';
import 'widgets/details/estimate_field.dart';
import 'widgets/details/start_date_field.dart';
import 'widgets/toolbar/action_item.dart';
import 'widgets/toolbar/note_toolbar.dart';

class TaskDialog extends StatelessWidget {
  const TaskDialog(this._controller, this._scrollController, this._title, this._body);
  final TaskController _controller;
  final ScrollController _scrollController;
  final Widget? _title;
  final Widget _body;

  Task get _task => _controller.task!;

  @override
  Widget build(BuildContext context) {
    return MTDialog(
      scrollController: _scrollController,
      topBar: MTToolBar(middle: _title),
      body: _body,
      rightBar: Container(
        color: b3Color.resolve(context),
        child: Column(
          children: [
            if (_task.canShowAssignee) TaskAssigneeField(_controller),
            TaskStartDateField(_controller),
            if (_task.hasDueDate || _task.canEdit) TaskDueDateField(_controller, bottomDivider: true),
            if (_task.canShowEstimate) TaskEstimateField(_controller, bottomDivider: true),
            const Spacer(),
            for (final at in _task.actionTypes)
              MTListTile(
                padding: const EdgeInsets.symmetric(horizontal: P3, vertical: P2),
                middle: TaskActionItem(at),
                bottomDivider: false,
                onTap: () => _controller.taskAction(at),
              ),
            const SizedBox(height: P2),
          ],
        ),
      ),
      rightBarWidth: 254,
      bottomBar: _task.canComment ? NoteToolbar(_controller) : null,
    );
  }
}
