// Copyright (c) 2023. Alexandr Moroz

import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_status.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_filter.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/status_controller.dart';
import 'task_card.dart';

class _ItemTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MIN_BTN_HEIGHT * 1,
      margin: const EdgeInsets.all(P2).copyWith(top: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS)),
        border: Border.all(width: 1, color: b2Color.resolve(context)),
      ),
    );
  }
}

class TasksBoard extends StatelessWidget {
  const TasksBoard(this.controller, {this.extra});
  final StatusController controller;
  final Widget? extra;

  Task get _task => controller.task;

  Widget _taskItem(Task t, {bool dragging = false}) {
    return TaskCard(
      t,
      board: true,
      showParent: _task.id != t.parent?.id,
      dragging: dragging,
    );
  }

  DragAndDropItem _taskBuilder(Task t) => DragAndDropItem(
        child: _taskItem(t),
        feedbackWidget: Transform(
          transform: Matrix4.rotationZ(-0.03),
          child: _taskItem(t, dragging: true),
        ),
        canDrag: t.canSetStatus,
      );

  DragAndDropList _columnBuilder(BuildContext context, int index) {
    final status = _task.statuses[index];
    final tasks = _task.subtasksForStatus(status.id!);
    return DragAndDropList(
      header: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (status.closed) const DoneIcon(true, color: f2Color),
          BaseText('$status', padding: const EdgeInsets.all(P)),
        ],
      ),
      children: [for (final t in tasks) _taskBuilder(t)],
      canDrag: false,
      contentsWhenEmpty: Container(),
      lastTarget: tasks.isEmpty ? _ItemTarget() : null,
      footer: status.closed && extra != null ? Center(child: extra) : null,
      // decoration: BoxDecoration(border: Border.all(color: fgL3Color.resolve(context))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Observer(
      builder: (_) => DragAndDropLists(
        children: [for (var i = 0; i < _task.statuses.length; i++) _columnBuilder(context, i)],
        onItemReorder: controller.moveTask,
        onListReorder: (int oldListIndex, int newListIndex) {},
        axis: Axis.horizontal,
        listWidth: SCR_XS_WIDTH,
        listPadding: EdgeInsets.only(top: P2, bottom: mq.padding.bottom + P2, left: P3),
        itemGhost: const SizedBox(height: MIN_BTN_HEIGHT),
        lastListTargetSize: 0,
        listDecoration: BoxDecoration(
          color: b1Color.resolve(context),
          borderRadius: const BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS)),
        ),
        lastItemTargetHeight: P2,
        listDragOnLongPress: !isWeb,
      ),
    );
  }
}
