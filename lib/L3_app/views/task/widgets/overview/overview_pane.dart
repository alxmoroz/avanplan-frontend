// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_state.dart';
import '../../../../presenters/task_stats.dart';
import '../../../../presenters/task_view.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../widgets/transfer/local_import_dialog.dart';
import '../create/task_create_button.dart';
import '../header/state_title.dart';
import '../tasks/tasks_group.dart';
import 'charts/chart_details.dart';
import 'charts/timing_chart.dart';
import 'charts/velocity_chart.dart';
import 'charts/volume_chart.dart';

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
                    margin: const EdgeInsets.only(bottom: P3),
                    onTap: () => localImportDialog(controller),
                  ),
                TaskCreateButton(_task.ws, parentTaskController: controller),
              ],
            )
          : Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_task.canCloseGroup)
                  BaseText.medium(
                    loc.state_closable_hint,
                    align: TextAlign.center,
                    color: f2Color,
                    padding: const EdgeInsets.only(bottom: P_2),
                  ),
                MTButton.main(
                  titleText: _task.canCloseGroup ? loc.close_action_title : loc.task_reopen_action_title,
                  leading: DoneIcon(_task.canCloseGroup, color: mainBtnTitleColor),
                  onTap: () => controller.statusController.setStatus(_task, close: !_task.closed),
                ),
              ],
            )
      : null;

  Widget _checkRecommendsItem(bool checked, String text) => MTListTile(
        leading: DoneIcon(checked, color: checked ? greenColor : f2Color, size: P6, solid: checked),
        middle: H3(text, color: checked ? f2Color : null),
        padding: const EdgeInsets.symmetric(vertical: 0),
        color: b2Color,
      );

  Widget get _requiredAddTask => _checkRecommendsItem(
        _task.state != TaskState.NO_SUBTASKS,
        '${loc.recommendation_add_tasks_title} ${loc.task_list_title.toLowerCase()}',
      );

  Widget get _requiredProgress => _checkRecommendsItem(
        _task.projectHasProgress,
        loc.recommendation_close_tasks_title,
      );

  Widget _line(BuildContext context) => Row(
        children: [
          const SizedBox(width: P3 - 1),
          Container(height: P3, width: 2, color: f2Color.resolve(context)),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => ListView(
        children: [
          MTAdaptive(
            force: true,
            padding: const EdgeInsets.symmetric(horizontal: P3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: P3),
                if (_task.isOpenedGroup)
                  !_task.canCloseGroup && (_task.canShowRecommendsEta || _task.projectLowStart)
                      ? H3('${loc.state_no_info_title}: ${_task.stateTitle.toLowerCase()}', align: TextAlign.center)
                      : TaskStateTitle(_task, place: StateTitlePlace.taskOverview),

                /// нет прогноза - показываем шаги
                if (_task.canShowRecommendsEta) ...[
                  const SizedBox(height: P3),
                  _task.projectHasProgress ? _requiredProgress : _requiredAddTask,
                  _line(context),
                  _task.projectHasProgress ? _requiredAddTask : _requiredProgress,
                ],

                if (_task.canShowVelocityVolumeCharts || _task.canShowTimeChart)
                  MTCardButton(
                    margin: const EdgeInsets.only(top: P3),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /// объем и скорость
                        if (_task.canShowVelocityVolumeCharts) ...[
                          const SizedBox(height: P3),
                          Row(children: [
                            Expanded(child: TaskVolumeChart(_task)),
                            const SizedBox(width: P3),
                            Expanded(child: VelocityChart(_task)),
                          ]),
                        ],

                        /// срок
                        if (_task.canShowTimeChart) ...[
                          SizedBox(height: _task.hasDueDate ? 0 : P4),
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
            const SizedBox(height: P3),
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
