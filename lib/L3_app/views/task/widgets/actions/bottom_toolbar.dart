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
import '../attachments/upload_dialog.dart';
import '../create/create_task_button.dart';
import '../local_transfer/local_import_dialog.dart';
import 'toggle_view_button.dart';

class TaskBottomToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskBottomToolbar(this._controller, {super.key, this.isTaskDialog = false});
  final TaskController _controller;
  final bool isTaskDialog;

  Task get _task => _controller.task!;

  @override
  Size get preferredSize => Size.fromHeight(P10 + (isTaskDialog ? P2 : 0));

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTAppBar(
        isBottom: true,
        color: b2Color,
        padding: const EdgeInsets.only(top: P2),
        middle: Row(
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
            if (_task.canComment) ...[
              UploadButton(
                _controller,
                padding: const EdgeInsets.symmetric(vertical: P).copyWith(left: P2, right: P + P_2),
              ),
              MTButton.icon(
                const NoteAddIcon(),
                padding: const EdgeInsets.symmetric(vertical: P).copyWith(left: P + P_2, right: P),
                onTap: () => _controller.notesController.create(),
              ),
            ],
            const SizedBox(width: P2),
          ],
        ),
      ),
    );
  }
}
