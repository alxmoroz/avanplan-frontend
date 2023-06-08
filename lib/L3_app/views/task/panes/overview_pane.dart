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

  Task get _task => controller.task;

  //TODO: кнопки "Закрыть" и "Переоткрыть" остаются тут?

  Widget? get bottomBar => !_task.isRoot && _task.shouldAddSubtask
      ? TaskAddButton(controller)
      : _task.canReopen || _task.canCloseGroup
          ? Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_task.canCloseGroup)
                  MediumText(
                    loc.state_closable_hint,
                    align: TextAlign.center,
                    color: lightGreyColor,
                    padding: const EdgeInsets.only(bottom: P_3),
                  ),
                MTButton.main(
                  titleText: _task.canCloseGroup ? loc.close_action_title : loc.task_reopen_action_title,
                  leading: DoneIcon(_task.canCloseGroup, color: lightBackgroundColor),
                  onTap: () => controller.setStatus(_task, close: !_task.closed),
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
        _task.overallState != TaskState.noSubtasks,
        '${loc.recommendation_add_tasks_title} ${_task.listTitle.toLowerCase()}',
      );

  Widget get _rItemProgress => _checkRecommendsItem(_task.projectHasProgress, loc.recommendation_close_tasks_title);

  Widget _line(BuildContext context) =>
      Row(children: [const SizedBox(width: P * 1.4), Container(height: P * 1.5, width: 2, color: greyColor.resolve(context))]);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        shrinkWrap: _task.isRoot,
        children: [
          MTAdaptive(
            force: true,
            padding: const EdgeInsets.symmetric(horizontal: P),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: P),
                if (_task.canShowState)
                  _task.isRoot
                      ? GroupStateTitle(_task, _task.subtasksState, place: StateTitlePlace.workspace)
                      : _task.canShowRecommendsEta || _task.projectLowStart
                          ? H3('${loc.state_no_info_title}: ${_task.stateTitle.toLowerCase()}', align: TextAlign.center)
                          : TaskStateTitle(_task, place: StateTitlePlace.taskOverview),

                /// нет прогноза - показываем шаги
                if (_task.canShowRecommendsEta) ...[
                  const SizedBox(height: P2),
                  _task.projectHasProgress ? _rItemProgress : _rItemAddTask,
                  _line(context),
                  _task.projectHasProgress ? _rItemAddTask : _rItemProgress,
                ],

                /// объем и скорость
                if (_task.canShowVelocityVolumeCharts) ...[
                  const SizedBox(height: P2),
                  Row(children: [
                    Expanded(child: TaskVolumeChart(_task)),
                    const SizedBox(width: P2),
                    Expanded(child: VelocityChart(_task)),
                  ]),
                ],

                /// срок
                if (_task.canShowTimeChart) ...[
                  const SizedBox(height: P),
                  TimingChart(_task),
                ],

                if (_task.canShowChartDetails) ...[
                  const SizedBox(height: P2),
                  MTButton.secondary(
                    titleText: loc.chart_details_action_title,
                    onTap: () => showChartsDetailsDialog(_task),
                  ),
                ],
              ],
            ),
          ),

          /// требующие внимания задачи
          if (_task.attentionalTasks.isNotEmpty) ...[
            const SizedBox(height: P2),
            if (!_task.isRoot)
              MTAdaptive(
                force: true,
                child: GroupStateTitle(_task, _task.subtasksState, place: StateTitlePlace.groupHeader),
              ),
            MTAdaptive(
              force: true,
              child: AttentionalTasks(_task),
            ),
          ],
        ],
      ),
    );
  }
}
