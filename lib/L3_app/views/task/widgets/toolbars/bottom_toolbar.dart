// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/toolbar.dart';
import '../../../../presenters/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';
import '../transfer/local_import_dialog.dart';
import '../view_settings/view_settings_button.dart';

class TaskBottomToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskBottomToolbar(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;

  @override
  Size get preferredSize => const Size.fromHeight(P10);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTAppBar(
        isBottom: true,
        innerHeight: preferredSize.height - P2,
        padding: const EdgeInsets.only(top: P2),
        middle: Row(
          children: [
            const SizedBox(width: P2),
            TasksViewSettingsButton(_controller, compact: true),
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
