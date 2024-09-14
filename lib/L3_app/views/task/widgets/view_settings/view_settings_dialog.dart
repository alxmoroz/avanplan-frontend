// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_view_settings.dart';
import '../../../../components/button.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/grid_button.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import '../../controllers/task_controller.dart';
import 'view_settings_controller.dart';

Future showTasksViewSettingsDialog(TaskController taskController) async {
  await showMTDialog<void>(
    _TasksViewSettingsDialog(TasksViewSettingsController(taskController)),
    maxWidth: SCR_XS_WIDTH,
  );
}

class _TasksViewSettingsDialog extends StatelessWidget {
  const _TasksViewSettingsDialog(this._vsController);
  final TasksViewSettingsController _vsController;

  Task get _task => _vsController.task;

  Future _save(BuildContext context) async {
    Navigator.of(context).pop();

    _task.viewSettings = _vsController.viewSettings;
    tasksMainController.refreshUI();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTDialog(
        topBar: MTAppBar(
          showCloseButton: true,
          color: b2Color,
          pageTitle: loc.view_settings_title,
          parentPageTitle: _task.title,
        ),
        body: ListView(
          shrinkWrap: true,
          children: [
            if (_task.canShowBoard) ...[
              MTListGroupTitle(titleText: loc.view_mode_title),
              MTGridButton(
                [
                  for (TasksViewMode v in TasksViewMode.values)
                    MTGridButtonItem(
                      v.name,
                      Intl.message('tasks_view_mode_${v.name.toLowerCase()}'),
                      iconData: v == TasksViewMode.LIST ? const ListIcon().iconData : const BoardIcon().iconData,
                    ),
                ],
                padding: const EdgeInsets.symmetric(horizontal: P3),
                value: _vsController.viewSettings.viewMode.name,
                onChanged: _vsController.setViewMode,
              ),
            ],
            // const MTListGroupTitle(titleText: "loc.tasks_view_filters"),

            MTButton.main(
              titleText: loc.save_action_title,
              onTap: () => _save(context),
              margin: const EdgeInsets.symmetric(vertical: P4),
            ),
          ],
        ),
      ),
    );
  }
}
