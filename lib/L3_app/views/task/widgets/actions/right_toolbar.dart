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
import '../../../../components/vertical_toolbar_controller.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../../usecases/attachments.dart';
import '../../usecases/note.dart';
import '../board/toggle_view_button.dart';
import '../create/create_task_button.dart';
import '../details/task_details.dart';
import '../transfer/local_import_dialog.dart';
import 'action_item.dart';
import 'popup_menu.dart';

class TaskRightToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskRightToolbar(this._taskController, this._controller, {super.key});
  final TaskController _taskController;
  final VerticalToolbarController _controller;

  Task get _task => _taskController.task;
  bool get _compact => _controller.compact;

  @override
  Size get preferredSize => Size.fromWidth(_controller.width);

  Widget _actions(BuildContext context) {
    return Column(
      children: [
        /// параметры задачи
        TaskDetails(_taskController, compact: _compact),
        const Spacer(),

        /// контекстные быстрые действия
        if (_task.canShowBoard) TaskToggleViewButton(_taskController, compact: _compact),
        if (_task.canCreateSubtask) CreateTaskButton(_taskController, compact: _compact),
        if (_task.canLocalImport)
          MTListTile(
            leading: const LocalImportIcon(circled: true, size: P6),
            middle: _compact ? null : BaseText(loc.task_transfer_import_action_title, color: mainColor, maxLines: 1),
            bottomDivider: false,
            onTap: () => localImportDialog(_taskController),
          ),

        if (_task.canComment) ...[
          MTListTile(
            leading: const NoteAddIcon(circled: true, size: P6),
            middle: _compact ? null : BaseText(loc.task_note_add_action_title, color: mainColor, maxLines: 1),
            bottomDivider: false,
            onTap: _taskController.createNote,
          ),
          MTListTile(
            leading: const AttachmentIcon(circled: true),
            middle: _compact ? null : BaseText(loc.attachment_add_action_title, color: mainColor, maxLines: 1),
            bottomDivider: false,
            onTap: _taskController.attachmentsController.startUpload,
          ),
        ],

        /// быстрые действия с задачей
        if (_task.quickActions.isNotEmpty) ...[
          const MTDivider(verticalIndent: P2),
          for (final ta in _task.quickActions)
            TaskActionItem(
              ta,
              compact: _compact,
              inPopup: false,
              onTap: () => _taskController.taskAction(context, ta),
            ),
        ],

        /// остальные действия с задачей
        if (_task.otherActions.isNotEmpty) TaskPopupMenu(_taskController, _task.otherActions, compact: _compact),
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
