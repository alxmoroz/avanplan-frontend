// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/images.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_view.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_feature_sets.dart';
import '../../../../usecases/task_stats.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../empty_state/no_tasks.dart';
import '../header/state_title.dart';
import '../tasks/tasks_group.dart';
import 'charts/chart_details.dart';
import 'charts/timing_chart.dart';
import 'charts/velocity_chart.dart';
import 'charts/volume_chart.dart';

class OverviewPane extends StatelessWidget {
  const OverviewPane(this.controller);
  final TaskController controller;

  Task get _task => controller.task!;

  Widget? get bottomBar => null;

  Widget _recommendation() {
    return _task.state == TaskState.NO_SUBTASKS && _task.subtasks.isEmpty
        ? NoTasks(controller, overview: true)
        : Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                MTImage(ImageName.save.name),
                const SizedBox(height: P3),
                H2(loc.recommendation_close_tasks_title, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3)),
                const SizedBox(height: P3),
                BaseText(loc.recommendation_close_tasks_hint, align: TextAlign.center, padding: const EdgeInsets.symmetric(horizontal: P3)),
                const SizedBox(height: P3),
                MTButton.main(
                  titleText: _task.isProject && _task.hfsGoals ? loc.recommendation_goto_goals : loc.recommendation_goto_tasks,
                  onTap: () => controller.selectTab(TaskTabKey.subtasks),
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      /// Нет прогноза - показываем рекомендации
      builder: (_) => _task.needUserActionState
          ? _recommendation()
          : ListView(
              children: [
                MTAdaptive(
                  force: true,
                  padding: const EdgeInsets.symmetric(horizontal: P3),
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      /// Основной статус
                      if (_task.isOpenedGroup) ...[
                        const SizedBox(height: P3),
                        !_task.canCloseGroup && (_task.needUserActionState || _task.projectLowStart)
                            ? H3('${loc.state_no_info_title}: ${_task.stateTitle.toLowerCase()}', align: TextAlign.center)
                            : TaskStateTitle(_task, place: StateTitlePlace.taskOverview),
                      ],

                      if (_task.canShowVelocityVolumeCharts || _task.canShowTimeChart)
                        MTCardButton(
                          padding: const EdgeInsets.symmetric(vertical: P3),
                          margin: const EdgeInsets.only(top: P3),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              /// объем и скорость
                              if (_task.canShowVelocityVolumeCharts) ...[
                                const SizedBox(height: P3),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [TaskVolumeChart(_task), VelocityChart(_task)],
                                ),
                              ],

                              /// срок
                              if (_task.canShowTimeChart) ...[
                                SizedBox(height: _task.hasDueDate ? 0 : P4),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: P3),
                                  child: TimingChart(_task),
                                )
                              ],
                            ],
                          ),
                          onTap: () => chartsDetailsDialog(_task),
                        ),

                      /// рекомендации
                      if (_task.canReopen || _task.canCloseGroup) ...[
                        const SizedBox(height: P3),
                        MTButton.main(
                          titleText: _task.canCloseGroup ? loc.close_action_title : loc.task_reopen_action_title,
                          leading: DoneIcon(_task.canCloseGroup, color: mainBtnTitleColor),
                          onTap: () => controller.statusController.setStatus(_task, close: !_task.closed),
                        ),
                      ],
                    ],
                  ),
                ),

                /// требующие внимания задачи
                if (_task.attentionalSubtasks.isNotEmpty) ...[
                  MTAdaptive(
                    force: true,
                    child: GroupStateTitle(_task.subtasksState, place: StateTitlePlace.groupHeader),
                  ),
                  MTAdaptive(
                    force: true,
                    child: TasksGroup(_task.attentionalSubtasks, standalone: false),
                  ),
                ],
              ],
            ),
    );
  }
}
