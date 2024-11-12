// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/board/board.dart';
import '../../../../components/board/board_column.dart';
import '../../../../components/board/dd_item.dart';
import '../../../../components/board/dd_item_target.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/services.dart';
import '../../controllers/project_statuses_controller.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';
import '../../usecases/status.dart';
import '../../usecases/tree.dart';
import 'column.dart';

class TasksBoard extends StatelessWidget {
  const TasksBoard(this._tc, {super.key, this.scrollController});
  final TaskController _tc;
  ProjectStatusesController get _psController => _tc.projectStatusesController;
  final ScrollController? scrollController;

  Future _itemReorder(int oldRowIndex, int oldColumnIndex, int newRowIndex, int newColumnIndex) async {
    final oldStatusId = _psController.projectStatusId(oldColumnIndex);
    final newStatusId = _psController.projectStatusId(newColumnIndex);
    final targetStatusTasks = _tc.subtasksForStatus(newStatusId);
    final incomingTask = _tc.subtasksForStatus(oldStatusId)[oldRowIndex];

    final sameCol = oldColumnIndex == newColumnIndex;

    // было перемещение
    if (!sameCol || oldRowIndex != newRowIndex) {
      // есть задачи в колонке
      if (targetStatusTasks.isNotEmpty) {
        Task? nextTask;
        Task? prevTask;

        final tasksCount = targetStatusTasks.length;
        final lastIndex = tasksCount - 1;

        // в середину или начало списка
        if (newRowIndex < lastIndex || (newRowIndex == lastIndex && !sameCol)) {
          final upToDown = oldRowIndex < newRowIndex;
          nextTask = targetStatusTasks[newRowIndex + (sameCol && upToDown ? 1 : 0)];
          if (newRowIndex > 0) {
            prevTask = targetStatusTasks[newRowIndex - 1 + (sameCol && upToDown ? 1 : 0)];
          }
        }
        // вставляем в конец списка в колонке, после последней задачи в списке
        else {
          prevTask = targetStatusTasks[lastIndex];
        }

        incomingTask.prevPosition = prevTask?.position;
        incomingTask.nextPosition = nextTask?.position;
      }
    }

    // смена колонки, статуса
    if (oldColumnIndex != newColumnIndex) {
      _tc.setStatus(incomingTask, stId: newStatusId);
    }
    // перемещение внутри одной колонки
    else if (oldRowIndex != newRowIndex) {
      TaskController(taskIn: incomingTask).save();
    }
  }

  // начали тащить
  bool _itemTargetOnWillAccept(MTDragNDropItem? incoming, MTDragNDropItemTarget target) {
    // final incomingTask = (incoming?.child as TaskCard).task;
    // final targetColumn = target.parent as MTBoardColumn;
    // return incomingTask.status != targetColumn.status;

    HapticFeedback.selectionClick();
    return true;
  }

  // толкаем соседний элемент
  bool _itemOnWillAccept(MTDragNDropItem? incoming, MTDragNDropItem target) {
    // final incomingTask = (incoming?.child as TaskCard).task;
    // final targetTask = (target.child as TaskCard).task;
    // return incomingTask.status != targetTask.status;

    if (incoming?.child != target.child) {
      HapticFeedback.selectionClick();
    }
    return true;
  }

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
          for (var i = 0; i < _psController.sortedStatuses.length; i++) TaskBoardColumn(_tc, i).builder(context),
          _statusAddButton,
        ],
        scrollController: scrollController,
        onItemReorder: _itemReorder,
        onItemDraggingChanged: (_, dragging) => dragging ? HapticFeedback.mediumImpact() : null,
        itemTargetOnWillAccept: _itemTargetOnWillAccept,
        itemOnWillAccept: _itemOnWillAccept,
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
