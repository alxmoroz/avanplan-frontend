// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities_extensions/task_type.dart';
import '../../../../components/constants.dart';
import '../../../../components/divider.dart';
import '../../../../components/toolbar_controller.dart';
import '../../../../components/vertical_toolbar.dart';
import '../../../../presenters/task_actions.dart';
import '../../../../presenters/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../create/create_task_button.dart';
import '../details/task_details.dart';
import '../view_settings/view_settings_button.dart';
import 'action_item.dart';
import 'popup_menu.dart';

class TaskRightToolbar extends StatelessWidget implements PreferredSizeWidget {
  const TaskRightToolbar(this._tc, this._tbc, {super.key});
  final TaskController _tc;
  final MTToolbarController _tbc;

  bool get _compact => _tbc.compact;

  @override
  Size get preferredSize => Size.fromWidth(_tbc.width);

  Widget _actions(BuildContext context) {
    final t = _tc.task;
    final showViewSettingsButton = t.isGroup && !_tc.settingsController.viewMode.isProject;
    final showCreateTaskButton = t.canCreateSubtask && t.hasSubtasks;
    return Column(
      children: [
        /// параметры задачи
        TaskDetails(_tc, compact: _compact),
        const Spacer(),

        /// Постоянные быстрые действия
        if (showViewSettingsButton) TasksViewSettingsButton(_tc, compact: _compact),
        if (showCreateTaskButton) ToolbarCreateTaskButton(_tc, compact: _compact),

        /// Динамические быстрые действия с задачей
        if (_tc.quickActions.isNotEmpty) ...[
          if (showViewSettingsButton || showCreateTaskButton) const MTDivider(verticalIndent: P2),
          for (final ta in _tc.quickActions) TaskActionItem(ta, _tc, compact: _compact, inToolbar: true),
        ],

        /// остальные действия с задачей (меню)
        TaskPopupMenu(_tc, inToolbar: true, compact: _compact),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _tbc.hidden
          ? const SizedBox()
          : VerticalToolbar(
              _tbc,
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
