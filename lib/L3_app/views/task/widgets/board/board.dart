// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/board/board.dart';
import '../../../../components/constants.dart';
import '../../../../usecases/task_status.dart';
import '../../controllers/status_controller.dart';
import '../../controllers/task_controller.dart';
import 'column.dart';

class TasksBoard extends StatelessWidget {
  const TasksBoard(this.taskController, {this.scrollController});
  final TaskController taskController;
  StatusController get controller => taskController.statusController;
  final ScrollController? scrollController;

  Task get _task => controller.task;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTBoard(
        children: [
          for (var i = 0; i < _task.statuses.length; i++) TaskBoardColumn(taskController, i).builder(),
        ],
        scrollController: scrollController,
        onItemReorder: controller.moveTask,
        onItemDraggingChanged: (_, dragging) => dragging ? HapticFeedback.mediumImpact() : null,
        itemTargetOnWillAccept: controller.canMoveTaskTarget,
        itemOnWillAccept: controller.canMoveTask,
        onColumnReorder: (int oldColumnIndex, int newColumnIndex) {},
        columnWidth: SCR_XS_WIDTH - P6,
        columnDivider: const SizedBox(width: P3),
        columnDividerOnLastChild: false,
        itemGhost: const SizedBox(height: MIN_BTN_HEIGHT),
        lastColumnTargetSize: 0,
        lastItemTargetHeight: P2,
        columnDragOnLongPress: !isWeb,
        itemDragOnLongPress: !isWeb,
      ),
    );
  }
}
