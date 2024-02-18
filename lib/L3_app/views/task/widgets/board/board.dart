// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L2_data/services/platform.dart';
import '../../../../components/board/board.dart';
import '../../../../components/constants.dart';
import '../../controllers/project_statuses_controller.dart';
import '../../controllers/status_controller.dart';
import '../../controllers/task_controller.dart';
import 'column.dart';

class TasksBoard extends StatelessWidget {
  const TasksBoard(this._taskController, {super.key, this.scrollController});
  final TaskController _taskController;
  StatusController get _statusController => _taskController.statusController;
  ProjectStatusesController get _psController => _taskController.projectStatusesController;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTBoard(
        children: [
          for (var i = 0; i < _psController.sortedStatuses.length; i++) TaskBoardColumn(_taskController, i).builder(),
        ],
        scrollController: scrollController,
        onItemReorder: _statusController.moveTask,
        onItemDraggingChanged: (_, dragging) => dragging ? HapticFeedback.mediumImpact() : null,
        itemTargetOnWillAccept: _statusController.canMoveTaskTarget,
        itemOnWillAccept: _statusController.canMoveTask,
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
