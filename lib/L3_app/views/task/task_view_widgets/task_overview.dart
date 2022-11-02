// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/state_presenter.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
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
              TaskStateTitle(_task, style: _taskStateTitleStyle),
              if (_task.canShowSpeedVolumeCharts) ...[
                SizedBox(height: onePadding),
                Row(children: [
                  Expanded(child: TaskVolumeChart(_task)),
                  Expanded(child: TaskSpeedChart(_task)),
                ]),
              ],
              if (_task.canShowTimeChart) ...[
                SizedBox(height: onePadding / 2),
                TaskTimeChart(_task),
              ],
            ],
          ),
        ),
        if (_task.warningTasks.isNotEmpty) ...[
          SizedBox(height: onePadding),
          if (!_task.isWorkspace)
            MediumText(
              '${_task.subtasksCount(_task.warningTasks.length)} ${loc.state_warning_tasks_title_suffix(_task.warningTasks.length)}',
              padding: EdgeInsets.symmetric(horizontal: onePadding),
              color: darkGreyColor,
              align: TextAlign.center,
            ),
          TaskOverviewWarnings(_task),
        ],
      ],
    );
  }
}
