// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/board/board_column.dart';
import '../../../../components/board/dd_item.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../tasks/task_card.dart';

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

class _Column extends MTBoardColumn {
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

class TaskBoardColumn {
  TaskBoardColumn(this._taskController, this._index);
  final TaskController _taskController;
  final int _index;

  Task get _parent => _taskController.task;
  ProjectStatus get _status => _taskController.projectStatusesController.sortedStatuses.elementAt(_index);
  List<Task> get _tasks => _parent.subtasksForStatus(_status.id!);

  Widget _taskItem(Task t, {bool dragging = false}) {
    return TaskCard(
      t,
      board: true,
      showParent: _parent.id != t.parent?.id,
      dragging: dragging,
    );
  }

  MTDragNDropItem _taskBuilder(Task t) => MTDragNDropItem(
        child: _taskItem(t),
        feedbackWidget: Transform(
          transform: Matrix4.rotationZ(-0.03),
          child: _taskItem(t, dragging: true),
        ),
        canDrag: t.canSetStatus,
      );

  Widget? get _footer => !_status.closed && _parent.canCreate
      ? MTListTile(
          middle: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PlusIcon(size: P3),
              const SizedBox(width: P),
              BaseText.medium(addSubtaskActionTitle(_parent), color: mainColor, maxLines: 1),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
          bottomDivider: false,
          onTap: () => _taskController.addSubtask(statusId: _status.id!),
        )
      : null;

  Widget get _header => Observer(
        builder: (_) => Row(
          children: [
            if (_parent.canEditProjectStatuses) const SizedBox(width: P6),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_status.closed) const DoneIcon(true, color: f2Color),
                  Flexible(child: H3('$_status', padding: const EdgeInsets.all(P), maxLines: 2, align: TextAlign.center)),
                ],
              ),
            ),
            if (_parent.canEditProjectStatuses) ...[
              MTButton.icon(
                const MenuIcon(),
                padding: const EdgeInsets.all(P),
                onTap: () => _taskController.projectStatusesController.edit(_status),
              ),
            ],
          ],
        ),
      );

  MTBoardColumn builder(BuildContext context) => _Column(
        _status,
        header: _header,
        children: [for (final t in _tasks) _taskBuilder(t)],
        canDrag: false,
        contentsWhenEmpty: Container(),
        lastTarget: _tasks.isEmpty ? const _ItemTarget() : null,
        footer: _footer,
      );
}
