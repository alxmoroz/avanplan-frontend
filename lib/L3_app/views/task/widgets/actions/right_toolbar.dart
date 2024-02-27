// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/divider.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/vertical_toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../board/toggle_view_button.dart';
import '../create/create_task_button.dart';
import '../details/task_details.dart';
import '../local_transfer/local_import_dialog.dart';
import 'action_item.dart';
import 'right_toolbar_controller.dart';

class TaskRightToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskRightToolbar(this._controller, {super.key});
  final TaskRightToolbarController _controller;

  TaskController get _taskController => _controller.taskController;
  Task get _task => _taskController.task!;

  @override
  Size get preferredSize => Size.fromWidth(_controller.width);

  List<Widget> _actionTiles(Iterable<TaskAction> actions) {
    return [
      for (final at in actions)
        MTListTile(
          middle: TaskActionItem(at, compact: _controller.compact, popup: false),
          bottomDivider: false,
          onTap: () async {
            await _taskController.taskAction(at);
            _controller.toggleShowActions();
          },
        )
    ];
  }

  Widget _actions(BuildContext context) {
    final otherActions = <TaskAction>[];
    final fastActions = <TaskAction>[];
    for (final a in _task.actions(context)) {
      if (_task.isTask && ([TaskAction.close, TaskAction.reopen].contains(a) || (_task.isInboxTask && a == TaskAction.localExport))) {
        fastActions.add(a);
      } else {
        otherActions.add(a);
      }
    }

    return Column(
      children: [
        /// параметры задачи
        TaskDetails(_taskController, compact: _controller.compact),
        const Spacer(),

        /// быстрые действия
        if (_task.canShowBoard) TaskToggleViewButton(_taskController, compact: _controller.compact),
        if (_task.canCreateSubtask) CreateTaskButton(_taskController, compact: _controller.compact),
        if (_task.canLocalImport)
          MTListTile(
            leading: const LocalImportIcon(circled: true, size: P6),
            middle: _controller.compact ? null : BaseText(loc.task_transfer_import_action_title, color: mainColor, maxLines: 1),
            bottomDivider: false,
            onTap: () => localImportDialog(_taskController),
          ),

        if (_task.canComment) ...[
          MTListTile(
            leading: const NoteAddIcon(circled: true, size: P6),
            middle: _controller.compact ? null : BaseText(loc.task_note_add_action_title, color: mainColor),
            bottomDivider: false,
            onTap: () => _taskController.notesController.create(),
          ),
          MTListTile(
            leading: const AttachmentIcon(circled: true),
            middle: _controller.compact ? null : BaseText(loc.attachment_add_action_title, color: mainColor),
            bottomDivider: false,
            onTap: () => _taskController.notesController.startUpload(),
          ),
        ],

        if (fastActions.isNotEmpty) ...[
          const MTDivider(verticalIndent: P2),
          ..._actionTiles(fastActions),
        ],

        /// остальные действия с задачей
        if (otherActions.isNotEmpty)
          if (_controller.showActions) ...[
            const MTDivider(verticalIndent: P2),
            ..._actionTiles(otherActions),
          ] else
            MTListTile(
              leading: const MenuIcon(circled: true, size: P6),
              middle: _controller.compact ? null : BaseText(loc.task_actions_menu_title, color: mainColor),
              bottomDivider: false,
              onTap: _controller.toggleShowActions,
            ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => VerticalToolbar(
        _controller,
        child: _task.isTask
            ? MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  padding: MediaQuery.paddingOf(context).add(const EdgeInsets.symmetric(vertical: P2)) as EdgeInsets,
                ),
                child: SafeArea(
                  top: false,
                  child: _actions(context),
                ),
              )
            : _actions(context),
      ),
    );
  }
}
