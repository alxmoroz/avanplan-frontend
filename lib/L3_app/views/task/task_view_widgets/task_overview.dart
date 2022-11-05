// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/state_presenter.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../task_charts/timing_chart.dart';
import '../task_charts/velocity_chart.dart';
import '../task_charts/volume_chart.dart';
import '../task_related_widgets/state_title.dart';
import '../task_related_widgets/task_overview_warnings.dart';
import '../task_view_widgets/task_chart_details.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview(this.task);
  @protected
  final Task task;

  TaskStateTitleStyle get _taskStateTitleStyle => task.isWorkspace ? TaskStateTitleStyle.L : TaskStateTitleStyle.M;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ListView(
      shrinkWrap: true,
      padding: padding.add(EdgeInsets.all(onePadding).copyWith(bottom: 0)),
      children: [
        if (task.showState) TaskStateTitle(task, style: _taskStateTitleStyle),

        /// объем и скорость
        if (task.showVelocityVolumeCharts) ...[
          SizedBox(height: onePadding * 2),
          Row(children: [TaskVolumeChart(task), const Spacer(), VelocityChart(task)]),
        ],

        /// срок
        if (task.showTimeChart) ...[
          SizedBox(height: onePadding),
          TimingChart(task),
        ],

        if (task.showChartDetails) ...[
          SizedBox(height: onePadding),
          MTButton.outlined(
            titleText: loc.chart_details_action_title,
            onTap: () => showChartsDetailsDialog(context, task),
          ),
        ],

        /// проблемные задачи
        if (task.warningTasks.isNotEmpty) ...[
          SizedBox(height: onePadding),
          if (!task.isWorkspace)
            MediumText(
              '${task.subtasksCount(task.warningTasks.length)} ${loc.state_warning_tasks_title_suffix(task.warningTasks.length)}',
              padding: EdgeInsets.symmetric(horizontal: onePadding),
              color: darkGreyColor,
              align: TextAlign.center,
            ),
          TaskOverviewWarnings(task),
        ],
      ],
    );
  }
}
