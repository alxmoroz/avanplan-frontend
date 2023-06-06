// Copyright (c) 2023. Alexandr Moroz

import 'dart:math';

import 'package:avanplan/L3_app/components/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_button.dart';
import '../../../../components/mt_card.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_filter_presenter.dart';
import '../../widgets/task_card.dart';
import 'tasks_pane_controller.dart';

class TasksBoardView extends StatelessWidget {
  const TasksBoardView(this.controller);

  final TasksPaneController controller;
  Task get task => mainController.taskForId(controller.task.wsId, controller.task.id);
  Workspace get ws => mainController.wsForId(task.wsId);

  Widget _taskBuilder(Task t) => TaskCard(
        mainController.taskForId(t.wsId, t.id),
        board: true,
        showBreadcrumbs: task.id != t.parent?.id,
      );

  List<Task> _tasksByStatus(int statusId) => task.sortedLeafTasks.where((t) => t.statusId == statusId).toList();

  Widget _columnBuilder(BuildContext context, int columnIndex) {
    final status = ws.statuses[columnIndex];
    final tasks = _tasksByStatus(status.id!);
    return MTCard(
      elevation: cardElevation,
      color: darkBackgroundColor,
      margin: EdgeInsets.only(left: columnIndex == 0 ? P2 : P, top: P, bottom: 0, right: columnIndex == ws.statuses.length - 1 ? P2 : P_2),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (status.closed) const DoneIcon(true, color: greyColor),
              NormalText('$status', padding: const EdgeInsets.all(P_2)),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, taskIndex) => _taskBuilder(tasks[taskIndex]),
              itemCount: tasks.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    final controller = PageController(
      viewportFraction: (min(w, SCR_S_WIDTH) * 0.85) / w,
      initialPage: 0,
    );
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          PageView.builder(
            allowImplicitScrolling: true,
            controller: controller,
            itemCount: ws.statuses.length,
            itemBuilder: _columnBuilder,
            padEnds: false,
          ),
          if (isWeb)
            Row(
              children: [
                MTButton.icon(
                  const ChevronCircleIcon(left: true),
                  margin: const EdgeInsets.all(P),
                  () => controller.previousPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                ),
                const Spacer(),
                MTButton.icon(
                  const ChevronCircleIcon(left: false),
                  margin: const EdgeInsets.all(P),
                  () => controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeInOut),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
