// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/icons.dart';
import '../../../components/mt_adaptive.dart';
import '../../../components/mt_button.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_filter_presenter.dart';
import '../../../presenters/task_state_presenter.dart';
import '../../../presenters/task_view_presenter.dart';
import '../../../usecases/task_available_actions.dart';
import '../controllers/task_controller.dart';
import '../widgets/charts/chart_details.dart';
import '../widgets/charts/timing_chart.dart';
import '../widgets/charts/velocity_chart.dart';
import '../widgets/charts/volume_chart.dart';
import '../widgets/state_title.dart';
import '../widgets/task_create_button.dart';
import '../widgets/tasks_group.dart';
import '../widgets/transfer/local_import_dialog.dart';

class OverviewPane extends StatelessWidget {
  const OverviewPane(this.controller);
  final TaskController controller;

  Task get _task => controller.task;

  bool get _showBottomBar => _task.shouldAddSubtask || _task.canReopen || _task.canCloseGroup;

  Widget? get bottomBar => _showBottomBar
      ? _task.shouldAddSubtask
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_task.canLocalImport)
                  MTButton.secondary(
                    leading: const LocalImportIcon(),
                    titleText: loc.task_transfer_import_action_title,
                    margin: const EdgeInsets.only(bottom: P),
                    onTap: () => localImportDialog(controller),
                  ),
                TaskCreateButton(controller.createController),
              ],
            )
          : Column(
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
                  onTap: () => controller.statusController.setStatus(_task, close: !_task.closed),
                ),
              ],
            )
      : null;

  Widget _checkRecommendsItem(bool checked, String text) => Row(children: [
        DoneIcon(checked, color: checked ? greenColor : greyTextColor, size: P * 3, solid: checked),
        const SizedBox(width: P_3),
        H3(text, color: checked ? lightGreyColor : null),
      ]);

  Widget get _requiredAddTask => _checkRecommendsItem(
        _task.state != TaskState.NO_SUBTASKS,
        '${loc.recommendation_add_tasks_title} ${loc.task_list_title.toLowerCase()}',
      );

  Widget get _requiredProgress => _checkRecommendsItem(
        _task.projectHasProgress,
        loc.recommendation_close_tasks_title,
      );

  Widget _line(BuildContext context) =>
      Row(children: [const SizedBox(width: P * 1.4), Container(height: P * 1.5, width: 2, color: greyTextColor.resolve(context))]);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
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
                  !_task.canCloseGroup && (_task.canShowRecommendsEta || _task.projectLowStart)
                      ? H3('${loc.state_no_info_title}: ${_task.stateTitle.toLowerCase()}', align: TextAlign.center)
                      : TaskStateTitle(_task, place: StateTitlePlace.taskOverview),

                /// нет прогноза - показываем шаги
                if (_task.canShowRecommendsEta) ...[
                  const SizedBox(height: P),
                  _task.projectHasProgress ? _requiredProgress : _requiredAddTask,
                  _line(context),
                  _task.projectHasProgress ? _requiredAddTask : _requiredProgress,
                ],

                if (_task.canShowVelocityVolumeCharts || _task.canShowTimeChart)
                  MTCardButton(
                    margin: const EdgeInsets.only(top: P),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// объем и скорость
                        if (_task.canShowVelocityVolumeCharts) ...[
                          const SizedBox(height: P),
                          Row(children: [
                            Expanded(child: TaskVolumeChart(_task)),
                            const SizedBox(width: P2),
                            Expanded(child: VelocityChart(_task)),
                          ]),
                        ],

                        /// срок
                        if (_task.canShowTimeChart) ...[
                          SizedBox(height: _task.hasDueDate ? 0 : P2),
                          TimingChart(_task),
                        ],
                      ],
                    ),
                    onTap: () => showChartsDetailsDialog(_task),
                  ),
              ],
            ),
          ),

          /// требующие внимания задачи
          if (_task.attentionalSubtasks.isNotEmpty) ...[
            const SizedBox(height: P2),
            MTAdaptive(
              force: true,
              child: GroupStateTitle(_task.type, _task.subtasksState, place: StateTitlePlace.groupHeader),
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
