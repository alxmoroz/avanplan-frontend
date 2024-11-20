// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
  const TaskBottomToolbar(this._tc, {super.key});
  final TaskController _tc;

  @override
  Size get preferredSize => const Size.fromHeight(P10);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _tc.task;
      return MTBottomBar(
        innerHeight: preferredSize.height - P2,
        middle: Row(
          children: [
            if (t.canEditViewSettings) ...[
              const SizedBox(width: P2),
              TasksViewSettingsButton(_tc, compact: true),
            ],
            const Spacer(),
            if (t.canLocalImport)
              MTButton.secondary(
                middle: const LocalImportIcon(),
                constrained: false,
                onTap: () => localImportDialog(_tc),
              ),
            if (t.canCreateSubtask) ...[
              const SizedBox(width: P2),
              CreateTaskButton(_tc, compact: true, buttonType: ButtonType.secondary),
            ],
            const SizedBox(width: P2),
          ],
        ),
      );
    });
  }
}
