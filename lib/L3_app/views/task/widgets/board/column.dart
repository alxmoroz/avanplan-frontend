// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/project_status.dart';
import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/board/board_column.dart';
import '../../../../components/board/dd_item.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../presenters/task_type.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/edit.dart';
import '../../usecases/tree.dart';
import '../tasks/card.dart';

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
  TaskBoardColumn(this._tc, this._index);
  final TaskController _tc;
  final int _index;

  ProjectStatus get _status => _tc.projectStatusesController.sortedStatuses.elementAt(_index);

  Widget _taskItem(Task t, int parentId, {bool dragging = false}) {
    return TaskCard(
      t,
      board: true,
      showParent: parentId != t.parent?.id,
      dragging: dragging,
    );
  }

  MTDragNDropItem _taskBuilder(Task t, int parentId) => MTDragNDropItem(
        child: _taskItem(t, parentId),
        feedbackWidget: Transform(
          transform: Matrix4.rotationZ(-0.03),
          child: _taskItem(t, parentId, dragging: true),
        ),
        canDrag: t.canSetStatus,
      );

  Widget _header(Task parent) {
    final canEditProjectStatuses = parent.canEditProjectStatuses;
    return Observer(
      builder: (_) => Row(
        children: [
          if (canEditProjectStatuses) const SizedBox(width: P6),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_status.closed) const DoneIcon(true, color: f2Color, size: P3),
                Flexible(
                  child: BaseText.medium(
                    '$_status',
                    align: TextAlign.center,
                    color: f2Color,
                    maxLines: 2,
                    padding: const EdgeInsets.symmetric(horizontal: P),
                  ),
                ),
              ],
            ),
          ),
          if (canEditProjectStatuses) ...[
            MTButton.icon(
              const MenuIcon(),
              padding: const EdgeInsets.all(P),
              onTap: () => _tc.projectStatusesController.edit(_status),
            ),
          ],
        ],
      ),
    );
  }

  Widget? _footer(Task parent) => _status.closed
      ? _tc.loadClosedButton(board: true)
      : parent.canCreate
          ? MTListTile(
              color: b3Color,
              middle: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PlusIcon(size: P3),
                  const SizedBox(width: P),
                  BaseText.medium(addTaskActionTitle(), color: mainColor, maxLines: 1),
                ],
              ),
              padding: const EdgeInsets.symmetric(horizontal: P2, vertical: P),
              onTap: () => _tc.addSubtask(statusId: _status.id!),
            )
          : null;

  MTBoardColumn builder(BuildContext context) {
    final tasks = _tc.subtasksForStatus(_status.id!);
    final parent = _tc.task;
    return _Column(
      _status,
      header: _header(parent),
      children: [for (final t in tasks) _taskBuilder(t, parent.id!)],
      canDrag: false,
      contentsWhenEmpty: Container(),
      lastTarget: tasks.isEmpty ? const _ItemTarget() : null,
      footer: _footer(parent),
    );
  }
}
