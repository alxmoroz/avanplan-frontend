// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/button.dart';
import '../../../../components/constants.dart';
import '../../../../components/toolbar.dart';
import '../../../../components/toolbar_controller.dart';
import '../../../../presenters/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';
import '../view_settings/view_settings_button.dart';

class TaskBottomToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskBottomToolbar(this._tc, this._tbc, {super.key});
  final TaskController _tc;
  final MTToolbarController _tbc;

  @override
  Size get preferredSize => Size.fromHeight(_tbc.height);

  @override
  Widget build(BuildContext context) {
    final t = _tc.task;
    return MTBottomBar(
      toolbarController: _tbc,
      middle: Row(
        children: [
          if (t.canEditViewSettings) ...[
            const SizedBox(width: P2),
            TasksViewSettingsButton(_tc, compact: true),
          ],
          const Spacer(),
          if (t.canCreateSubtask) ...[
            const SizedBox(width: P2),
            ToolbarCreateTaskButton(_tc, compact: true, buttonType: ButtonType.secondary),
          ],
          const SizedBox(width: P2),
        ],
      ),
    );
  }
}
