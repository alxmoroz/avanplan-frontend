// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/task_view_settings.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/grid_button.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_actions.dart';
import 'assignee_filter_field.dart';
import 'view_settings_controller.dart';

Future showTasksViewSettingsDialog(Task task) async {
  await showMTDialog<void>(
    _TasksViewSettingsDialog(TaskViewSettingsController(task)),
    maxWidth: SCR_XS_WIDTH,
  );
}

class _TasksViewSettingsDialog extends StatelessWidget {
  const _TasksViewSettingsDialog(this._vsController);
  final TaskViewSettingsController _vsController;

  Task get _task => _vsController.task;

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
                  for (TaskViewMode vm in TaskViewMode.values)
                    MTGridButtonItem(
                      vm.name,
                      Intl.message('tasks_view_mode_${vm.name.toLowerCase()}'),
                      iconData: vm == TaskViewMode.LIST ? const ListIcon().iconData : const BoardIcon().iconData,
                    ),
                ],
                padding: const EdgeInsets.symmetric(horizontal: P3),
                value: _vsController.viewMode.name,
                onChanged: _vsController.setViewMode,
              ),
            ],
            MTListGroupTitle(titleText: loc.view_filters_title, topMargin: _task.canShowBoard ? null : 0),
            TasksAssigneeFilterField(_vsController),
          ],
        ),
      ),
    );
  }
}
