// Copyright (c) 2023. Alexandr Moroz

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/status.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../../main.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_filter_presenter.dart';
import '../../../../usecases/task_ext_actions.dart';
import '../../widgets/task_card.dart';
import 'tasks_pane_controller.dart';

class TasksBoardView extends StatelessWidget {
  const TasksBoardView(this.controller);

  final TasksPaneController controller;
  Task get _task => mainController.taskForId(controller.task.wsId, controller.task.id);
  Workspace get _ws => mainController.wsForId(_task.wsId);

  Future _setStatus(int oldTaskIndex, int oldStatusIndex, int newTaskIndex, int newStatusIndex) async {
    if (oldStatusIndex != newStatusIndex) {
      final oldStatusId = _ws.statuses[oldStatusIndex].id!;
      final newStatusId = _ws.statuses[newStatusIndex].id!;

      final task = _task.sortedLeafTasksForStatus(oldStatusId)[oldTaskIndex];
      await controller.taskController.setStatus(task, statusId: newStatusId);
    }
  }

  DragAndDropItem _taskBuilder(Task t) => DragAndDropItem(
        child: TaskCard(
          mainController.taskForId(t.wsId, t.id),
          board: true,
          showBreadcrumbs: _task.id != t.parent?.id,
        ),
        canDrag: t.canSetStatus,
      );

  DragAndDropList _columnBuilder(Status status) {
    final tasks = _task.sortedLeafTasksForStatus(status.id!);
    return DragAndDropList(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (status.closed) const DoneIcon(true, color: greyColor),
          NormalText('$status', padding: const EdgeInsets.all(P_2)),
        ],
      ),
      children: [for (final t in tasks) _taskBuilder(t)],
      canDrag: false,
      contentsWhenEmpty: const SizedBox(height: 0),
      lastTarget: const SizedBox(height: P2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          DragAndDropLists(
            children: [for (final status in _ws.statuses) _columnBuilder(status)],
            onItemReorder: _setStatus,
            onListReorder: (int oldListIndex, int newListIndex) {},
            axis: Axis.horizontal,
            listWidth: SCR_S_WIDTH * 0.8,
            listPadding: const EdgeInsets.symmetric(horizontal: P_2).copyWith(top: P),
            // itemGhost: const SizedBox(height: P2),
            listDecoration: BoxDecoration(
              color: darkBackgroundColor.resolve(rootKey.currentContext!),
              borderRadius: const BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS)),
            ),
            contentsWhenEmpty: const SizedBox(height: P3),
            lastItemTargetHeight: 0,
            listDragOnLongPress: !isWeb,
          ),
        ],
      ),
    );
  }
}
