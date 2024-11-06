// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/divider.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../components/vertical_toolbar.dart';
import '../../../../components/vertical_toolbar_controller.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';
import '../details/task_details.dart';
import '../transfer/local_import_dialog.dart';
import '../view_settings/view_settings_button.dart';
import 'action_item.dart';
import 'popup_menu.dart';

class TaskRightToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskRightToolbar(this._tc, this._vtc, {super.key});
  final TaskController _tc;
  final VerticalToolbarController _vtc;

  bool get _compact => _vtc.compact;

  @override
  Size get preferredSize => Size.fromWidth(_vtc.width);

  Widget _actions(BuildContext context) {
    final t = _tc.task;
    return Column(
      children: [
        /// параметры задачи
        TaskDetails(_tc, compact: _compact),
        const Spacer(),

        /// контекстные быстрые действия
        if (t.canEditViewSettings) TasksViewSettingsButton(_tc, compact: _compact),
        if (t.canCreateSubtask) CreateTaskButton(_tc, compact: _compact),
        if (t.canLocalImport)
          MTListTile(
            leading: const LocalImportIcon(circled: true, size: DEF_TAPPABLE_ICON_SIZE),
            middle: _compact ? null : BaseText(loc.action_transfer_import_tasks_title, color: mainColor, maxLines: 1),
            bottomDivider: false,
            onTap: () => localImportDialog(_tc),
          ),

        /// быстрые действия с задачей
        if (t.quickActions.isNotEmpty) ...[
          const MTDivider(verticalIndent: P2),
          for (final ta in t.quickActions)
            TaskActionItem(
              ta,
              compact: _compact,
              inPopup: false,
              onTap: () => _tc.taskAction(context, ta),
            ),
        ],

        /// остальные действия с задачей
        if (t.otherActions.isNotEmpty) TaskPopupMenu(_tc, t.otherActions, compact: _compact),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _vtc.hidden
          ? const SizedBox()
          : VerticalToolbar(
              _vtc,
              child: _tc.task.isTask
                  ? MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        padding: MediaQuery.paddingOf(context).add(const EdgeInsets.only(bottom: P2)) as EdgeInsets,
                      ),
                      child: SafeArea(child: _actions(context)),
                    )
                  : _actions(context),
            ),
    );
  }
}
