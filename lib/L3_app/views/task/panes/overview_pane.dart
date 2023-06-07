// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_level.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../../presenters/task_level_presenter.dart';
import '../../../presenters/task_state_presenter.dart';
import '../../../presenters/task_view_presenter.dart';
import '../../../usecases/task_ext_actions.dart';
import '../task_view_controller.dart';
import '../widgets/attentional_tasks.dart';
import '../widgets/charts/chart_details.dart';
import '../widgets/charts/timing_chart.dart';
import '../widgets/charts/velocity_chart.dart';
import '../widgets/charts/volume_chart.dart';
import '../widgets/state_title.dart';
import '../widgets/task_add_button.dart';

class OverviewPane extends StatelessWidget {
  const OverviewPane(this.controller);
  final TaskViewController controller;

  Task get task => controller.task;

  //TODO: кнопки "Закрыть" и "Переоткрыть" остаются тут?

  Widget? get bottomBar => !task.isRoot && task.shouldAddSubtask
      ? TaskAddButton(controller)
      : task.canReopen || task.canCloseGroup
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (task.canCloseGroup)
                  MediumText(
                    loc.state_closable_hint,
                    align: TextAlign.center,
                    color: lightGreyColor,
                    padding: const EdgeInsets.only(bottom: P_3),
                  ),
                MTButton.main(
                  titleText: task.canCloseGroup ? loc.close_action_title : loc.task_reopen_action_title,
                  leading: DoneIcon(task.canCloseGroup, color: lightBackgroundColor),
                  onTap: () => controller.setStatus(close: !task.closed),
                ),
              ],
            )
          : null;

  Widget _checkRecommendsItem(bool checked, String text) => Row(children: [
        DoneIcon(checked, color: checked ? greenColor : greyColor, size: P * 3, solid: checked),
        const SizedBox(width: P_3),
        H4(text),
      ]);

  Widget get _rItemAddTask => _checkRecommendsItem(
        task.overallState != TaskState.noSubtasks,
        '${loc.recommendation_add_tasks_title} ${task.listTitle.toLowerCase()}',
      );

  Widget get _rItemProgress => _checkRecommendsItem(task.projectHasProgress, loc.recommendation_close_tasks_title);

  Widget _line(BuildContext context) =>
      Row(children: [const SizedBox(width: P * 1.4), Container(height: P * 1.5, width: 2, color: greyColor.resolve(context))]);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: task.isRoot,
        children: [
          MTAdaptive(
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: P),
                if (task.canShowState)
                  task.isRoot
                      ? GroupStateTitle(task, task.subtasksState, place: StateTitlePlace.workspace)
                      : task.canShowRecommendsEta || task.projectLowStart
                          ? H3('${loc.state_no_info_title}: ${task.stateTitle.toLowerCase()}', align: TextAlign.center)
                          : TaskStateTitle(task, place: StateTitlePlace.taskOverview),

                /// нет прогноза - показываем шаги
                if (task.canShowRecommendsEta) ...[
                  const SizedBox(height: P2),
                  task.projectHasProgress ? _rItemProgress : _rItemAddTask,
                  _line(context),
                  task.projectHasProgress ? _rItemAddTask : _rItemProgress,
                ],

                /// объем и скорость
                if (task.canShowVelocityVolumeCharts) ...[
                  const SizedBox(height: P2),
                  Row(children: [
                    Expanded(child: TaskVolumeChart(task)),
                    const SizedBox(width: P2),
                    Expanded(child: VelocityChart(task)),
                  ]),
                ],

                /// срок
                if (task.canShowTimeChart) ...[
                  const SizedBox(height: P),
                  TimingChart(task),
                ],

                if (task.canShowChartDetails) ...[
                  const SizedBox(height: P2),
                  MTButton.secondary(
                    titleText: loc.chart_details_action_title,
                    onTap: () => showChartsDetailsDialog(task),
                  ),
                ],
              ],
            ),
            force: true,
          ),

          /// требующие внимания задачи
          if (task.attentionalTasks.isNotEmpty) ...[
            const SizedBox(height: P2),
            if (!task.isRoot) MTAdaptive(GroupStateTitle(task, task.subtasksState, place: StateTitlePlace.groupHeader), force: true),
            MTAdaptive(
              AttentionalTasks(task),
              force: true,
            ),
          ],
        ],
      ),
    );
  }
}
