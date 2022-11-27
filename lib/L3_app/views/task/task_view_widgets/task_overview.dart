// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_level.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/state_presenter.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
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

  Widget _checkRecommendsItem(bool checked, String text) => Row(children: [
        DoneIcon(checked, color: checked ? greenColor : darkGreyColor, size: P * 3, solid: checked),
        const SizedBox(width: P_3),
        H4(text),
      ]);

  Widget _line(BuildContext context) =>
      Row(children: [const SizedBox(width: P * 1.4), Container(height: P * 1.5, width: 2, color: darkGreyColor.resolve(context))]);

  @override
  Widget build(BuildContext context) {
    // final padding = MediaQuery.of(context).padding;
    return ListView(
      shrinkWrap: true,
      // padding: padding.add(const EdgeInsets.all(P).copyWith(bottom: 0)),
      children: [
        Padding(
            padding: const EdgeInsets.all(P).copyWith(bottom: 0),
            child: Column(children: [
              if (task.showState)
                task.isWorkspace
                    ? GroupStateTitle(task, task.subtasksState, place: StateTitlePlace.workspace)
                    : task.showRecommendsEta || task.projectLowStart
                        ? H3('${loc.state_no_info_title}: ${task.stateTitle.toLowerCase()}', align: TextAlign.center)
                        : TaskStateTitle(task, place: StateTitlePlace.taskOverview),

              /// нет прогноза - показываем шаги
              if (task.showRecommendsEta) ...[
                const SizedBox(height: P2),
                _checkRecommendsItem(
                    task.overallState != TaskState.noSubtasks, '${loc.recommendation_add_tasks_title} ${task.listTitle.toLowerCase()}'),
                _line(context),
                _checkRecommendsItem(
                    task.overallState != TaskState.noSubtasks && task.closedLeafTasksCount > 0, loc.recommendation_close_tasks_title),
              ],

              /// объем и скорость
              if (task.showVelocityVolumeCharts) ...[
                const SizedBox(height: P2),
                Row(children: [
                  Expanded(child: TaskVolumeChart(task)),
                  const SizedBox(width: P2),
                  Expanded(child: VelocityChart(task)),
                ]),
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
            ])),

        /// требующие внимания задачи
        if (task.attentionalTasks.isNotEmpty) ...[
          const SizedBox(height: P2),
          if (!task.isWorkspace)
            H4(task.subtasksStateTitle, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P).copyWith(bottom: P_3)),
          AttentionalTasks(task),
        ],
      ],
    );
  }
}
