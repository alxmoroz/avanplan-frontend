// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L2_data/services/platform.dart';
import '../../../../components/board/board.dart';
import '../../../../components/board/board_column.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
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

  MTBoardColumn get _statusAddButton => MTBoardColumn(
        children: [],
        hasTarget: false,
        canDrag: false,
        header: MTListTile(
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [const PlusIcon(size: P3), const SizedBox(width: P), BaseText.medium(loc.status_title, color: mainColor, maxLines: 1)],
          ),
          minHeight: P4,
          bottomDivider: false,
          onTap: _psController.create,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTBoard(
        children: [
          for (var i = 0; i < _psController.sortedStatuses.length; i++) TaskBoardColumn(_taskController, i).builder(),
          _statusAddButton,
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
