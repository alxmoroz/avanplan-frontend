// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../usecases/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../board/toggle_view_button.dart';
import '../create/create_task_button.dart';
import '../local_transfer/local_import_dialog.dart';

class TaskBottomToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskBottomToolbar(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task!;

  @override
  Size get preferredSize => const Size.fromHeight(P10);

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
            if (_task.isTask && _task.canClose)
              MTButton.main(
                titleText: loc.close_action_title,
                leading: const DoneIcon(true, color: mainBtnTitleColor),
                constrained: false,
                color: greenColor,
                padding: const EdgeInsets.symmetric(horizontal: P3),
                loading: _controller.fData(TaskFCode.status.index).loading,
                onTap: () => _controller.statusController.setStatus(_task, close: true),
              ),
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
              MTButton.secondary(
                middle: const AttachmentIcon(size: P4),
                constrained: false,
                onTap: () => _controller.notesController.startUpload(),
              ),
              const SizedBox(width: P2),
              MTButton.secondary(
                middle: const NoteAddIcon(),
                constrained: false,
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
