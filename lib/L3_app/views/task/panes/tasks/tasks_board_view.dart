// Copyright (c) 2023. Alexandr Moroz

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text_widgets.dart';
import '../../../../presenters/task_filter_presenter.dart';
import '../../../../usecases/task_ext_actions.dart';
import '../../widgets/task_card.dart';
import 'tasks_pane_controller.dart';

class _ItemTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MIN_BTN_HEIGHT * 1,
      margin: const EdgeInsets.all(P).copyWith(top: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS)),
        border: Border.all(width: 1, color: backgroundColor.resolve(context)),
      ),
    );
  }
}

class TasksBoardView extends StatelessWidget {
  const TasksBoardView(this.controller);
  final TasksPaneController controller;

  Task get _task => controller.taskController.task;
  Workspace get _ws => controller.taskController.ws;

  Future _setStatus(int oldTaskIndex, int oldStatusIndex, int newTaskIndex, int newStatusIndex) async {
    if (oldStatusIndex != newStatusIndex) {
      final oldStatusId = _ws.statuses[oldStatusIndex].id!;
      final newStatusId = _ws.statuses[newStatusIndex].id!;

      final task = _task.leavesForStatus(oldStatusId)[oldTaskIndex];
      await controller.taskController.setStatus(task, statusId: newStatusId);
    }
  }

  DragAndDropItem _taskBuilder(Task t) => DragAndDropItem(
        child: TaskCard(
          t,
          board: true,
          showParent: _task.id != t.parent?.id,
        ),
        feedbackWidget: Transform(
          transform: Matrix4.rotationZ(-0.03),
          child: TaskCard(
            t,
            board: true,
            showParent: _task.id != t.parent?.id,
            dragging: true,
          ),
        ),
        canDrag: t.canSetStatus,
      );

  DragAndDropList _columnBuilder(int index) {
    final status = _ws.statuses[index];
    final tasks = _task.leavesForStatus(status.id!);
    return DragAndDropList(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (status.closed) const DoneIcon(true, color: greyColor),
          NormalText(
            '$status',
            padding: const EdgeInsets.all(P_2),
          ),
        ],
      ),
      children: [for (final t in tasks) _taskBuilder(t)],
      canDrag: false,
      contentsWhenEmpty: Container(),
      lastTarget: tasks.isEmpty ? _ItemTarget() : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Observer(
      builder: (_) => DragAndDropLists(
        children: [for (var i = 0; i < _ws.statuses.length; i++) _columnBuilder(i)],
        onItemReorder: _setStatus,
        onListReorder: (int oldListIndex, int newListIndex) {},
        axis: Axis.horizontal,
        listWidth: SCR_S_WIDTH * 0.9,
        listPadding: EdgeInsets.only(top: P, bottom: mq.padding.bottom + P, left: P),
        itemGhost: const SizedBox(height: MIN_BTN_HEIGHT),
        lastListTargetSize: 0,
        listDecoration: BoxDecoration(
          color: darkBackgroundColor.resolve(context),
          borderRadius: const BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS)),
        ),
        lastItemTargetHeight: P,
        listDragOnLongPress: !isWeb,
      ),
    );
  }
}
