// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';

import '../../../../../L1_domain/entities/task_local_settings.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/grid_button.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/toolbar.dart';
import '../../../../presenters/task_actions.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../../controllers/task_settings_controller.dart';
import 'assignee_filter_field.dart';

Future showTaskSettingsDialog(TaskController tc) async {
  await showMTDialog(
    _TaskSettingsDialog(tc.settingsController),
    maxWidth: SCR_XS_WIDTH,
  );
}

class _TaskSettingsDialog extends StatelessWidget {
  const _TaskSettingsDialog(this._tsc);
  final TaskSettingsController _tsc;

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _tsc.task;
      final showBoard = t.canShowBoard;
      final showAssigneeFilter = t.canShowAssigneeFilter;
      return MTDialog(
        topBar: MTTopBar(pageTitle: loc.view_settings_title, parentPageTitle: t.title),
        body: ListView(
          shrinkWrap: true,
          children: [
            if (showBoard) ...[
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
                value: _tsc.viewMode.name,
                onChanged: _tsc.setViewMode,
              ),
            ],
            if (showAssigneeFilter) ...[
              MTListGroupTitle(titleText: loc.view_filters_title, topMargin: showBoard ? null : 0),
              TasksAssigneeFilterField(_tsc),
            ]
          ],
        ),
        forceBottomPadding: !showAssigneeFilter,
      );
    });
  }
}
