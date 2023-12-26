// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_status.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/status_controller.dart';
import '../tasks/task_card.dart';
import 'drag_and_drop_lists.dart';

class _ItemTarget extends StatelessWidget {
  const _ItemTarget();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MIN_BTN_HEIGHT * 1,
      margin: const EdgeInsets.all(P2).copyWith(top: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(DEF_BORDER_RADIUS)),
        border: Border.all(width: 1, color: b1Color.resolve(context)),
      ),
    );
  }
}

class _Column extends DragAndDropList {
  _Column(
    this.status, {
    required super.children,
    super.header,
    super.footer,
    super.contentsWhenEmpty,
    super.lastTarget,
    super.canDrag,
  });

  final ProjectStatus status;
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
    final status = _task.statuses.elementAt(index);
    final tasks = _task.subtasksForStatus(status.id!);
    return _Column(
      status,
      header: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (status.closed) const DoneIcon(true, color: f2Color),
          Flexible(child: H3('$status', padding: const EdgeInsets.all(P), maxLines: 2, align: TextAlign.center)),
        ],
      ),
      children: [for (final t in tasks) _taskBuilder(t)],
      canDrag: false,
      contentsWhenEmpty: Container(),
      lastTarget: tasks.isEmpty ? const _ItemTarget() : null,
      footer: status.closed && extra != null ? Center(child: extra) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => DragAndDropLists(
        children: [
          for (var i = 0; i < _task.statuses.length; i++) _columnBuilder(context, i),
        ],
        onItemReorder: controller.moveTask,
        onItemDraggingChanged: (_, dragging) => dragging ? HapticFeedback.mediumImpact() : null,
        itemTargetOnWillAccept: controller.canMoveTaskTarget,
        itemOnWillAccept: controller.canMoveTask,
        onListReorder: (int oldListIndex, int newListIndex) {},
        listWidth: SCR_XS_WIDTH - P6,
        listDivider: const SizedBox(width: P3),
        listDividerOnLastChild: false,
        itemGhost: const SizedBox(height: MIN_BTN_HEIGHT),
        lastListTargetSize: 0,
        lastItemTargetHeight: P2,
        listDragOnLongPress: !isWeb,
        itemDragOnLongPress: !isWeb,
      ),
    );
  }
}
