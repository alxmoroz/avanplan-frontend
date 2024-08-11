// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/toolbar.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../board/toggle_view_button.dart';
import '../create/create_task_button.dart';
import '../notes/note_field.dart';
import '../transfer/local_import_dialog.dart';

class TaskBottomToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskBottomToolbar(this._controller, {super.key, this.extraHeight = 0.0});
  final TaskController _controller;
  final double extraHeight;

  Task get _task => _controller.task;

  @override
  Size get preferredSize => Size.fromHeight(P10 + extraHeight);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTAppBar(
        isBottom: true,
        color: b2Color,
        innerHeight: preferredSize.height - P2,
        padding: const EdgeInsets.only(top: P2),
        middle: _task.canComment
            ? NoteField(_controller, standalone: true)
            : Row(
                children: [
                  const SizedBox(width: P2),
                  if (_task.canShowBoard) TaskToggleViewButton(_controller),
                  const Spacer(),
                  if (_task.canLocalImport)
                    MTButton.secondary(
                      middle: const LocalImportIcon(),
                      constrained: false,
                      onTap: () => localImportDialog(_controller),
                    ),
                  if (_task.canCreateSubtask) ...[
                    const SizedBox(width: P2),
                    CreateTaskButton(_controller, compact: true, type: ButtonType.secondary),
                  ],
                  const SizedBox(width: P2),
                ],
              ),
      ),
    );
  }
}
