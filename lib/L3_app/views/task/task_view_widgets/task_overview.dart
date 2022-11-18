// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/state_presenter.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../task_charts/timing_chart.dart';
import '../task_charts/velocity_chart.dart';
import '../task_charts/volume_chart.dart';
import '../task_related_widgets/attentional_tasks.dart';
import '../task_related_widgets/state_title.dart';
import '../task_view_widgets/task_chart_details.dart';

class TaskOverview extends StatelessWidget {
  const TaskOverview(this.task);
  @protected
  final Task task;

  @override
  Widget build(BuildContext context) {
    final padding = MediaQuery.of(context).padding;
    return ListView(
      shrinkWrap: true,
      padding: padding.add(const EdgeInsets.all(P).copyWith(bottom: 0)),
      children: [
        if (task.showState)
          task.isWorkspace
              ? GroupStateTitle(task, task.overallState, place: StateTitlePlace.workspace)
              : TaskStateTitle(task, place: StateTitlePlace.taskOverview),

        /// объем и скорость
        if (task.showVelocityVolumeCharts) ...[
          const SizedBox(height: P2),
          Row(children: [TaskVolumeChart(task), const Spacer(), VelocityChart(task)]),
        ],

        /// срок
        if (task.showTimeChart) ...[
          const SizedBox(height: P),
          TimingChart(task),
        ],

        if (task.showChartDetails) ...[
          const SizedBox(height: P),
          MTButton.outlined(
            titleText: loc.chart_details_action_title,
            onTap: () => showChartsDetailsDialog(context, task),
          ),
        ],

        /// требующие внимания задачи
        if (task.attentionalTasks.isNotEmpty) ...[
          const SizedBox(height: P2),
          if (!task.isWorkspace) H4(task.subtasksStateTitle, align: TextAlign.center),
          AttentionalTasks(task),
        ],
      ],
    );
  }
}
