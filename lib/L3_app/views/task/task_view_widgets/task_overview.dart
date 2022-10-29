// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../components/constants.dart';
import '../../../presenters/state_presenter.dart';
import '../task_charts/task_speed_chart.dart';
import '../task_charts/task_time_chart.dart';
import '../task_charts/task_volume_chart.dart';
import '../task_related_widgets/state_title.dart';
import '../task_related_widgets/task_overview_warnings.dart';
import '../task_view_controller.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview(this.controller);
  @protected
  final TaskViewController controller;

  Task get _task => controller.task;
  TaskStateTitleStyle get _taskStateTitleStyle => _task.isWorkspace ? TaskStateTitleStyle.L : TaskStateTitleStyle.M;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: EdgeInsets.all(onePadding).copyWith(bottom: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: onePadding / 2),
              TaskStateTitle(_task, style: _taskStateTitleStyle),
              if (_task.canShowSpeedVolumeCharts) ...[
                SizedBox(height: onePadding / 2),
                Row(children: [
                  Expanded(child: TaskVolumeChart(_task)),
                  Expanded(child: TaskSpeedChart(_task)),
                ]),
                SizedBox(height: onePadding / 2),
              ],
              if (_task.canShowTimeChart) TaskTimeChart(_task),
            ],
          ),
        ),
        TaskOverviewWarnings(_task),
      ],
    );
  }
}
