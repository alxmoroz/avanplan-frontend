// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_level.dart';
import '../../../components/constants.dart';
import '../../../presenters/task_state_presenter.dart';
import '../task_view_controller.dart';
import '../task_view_widgets/task_time_chart.dart';
import 'task_overview_advices.dart';
import 'task_overview_warnings.dart';
import 'task_state_title.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview(this.controller);
  @protected
  final TaskViewController controller;

  Task get _task => controller.task;
  bool get _isWorkspace => _task.isWorkspace;
  TaskStateTitleStyle get _taskStateTitleStyle => _isWorkspace ? TaskStateTitleStyle.L : TaskStateTitleStyle.M;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsets.all(onePadding).copyWith(bottom: 0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            if (_task.showTimeChart) TaskTimeChart(_task),
            if (_task.showSubtasksState) ...[
              SizedBox(height: onePadding),
              TaskStateTitle(_task, style: _taskStateTitleStyle, forSubtasks: true),
            ],
          ]),
        ),
        if (_task.showSubtasksState) TaskOverviewWarnings(_task) else TaskOverviewAdvices(_task),
      ],
    );
  }
}
