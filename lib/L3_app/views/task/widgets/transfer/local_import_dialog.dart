// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../../../L1_domain/usecases/task_comparators.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/mt_button.dart';
import '../../../../components/mt_checkbox.dart';
import '../../../../components/mt_dialog.dart';
import '../../../../components/mt_list_tile.dart';
import '../../../../components/mt_shadowed.dart';
import '../../../../components/mt_toolbar.dart';
import '../../../../components/text_widgets.dart';
import '../../../../extra/services.dart';
import '../../task_view_controller.dart';
import 'local_import_controller.dart';
import 'select_task_dialog.dart';

Future localImportDialog(TaskViewController taskController) async {
  final destinationGoal = taskController.task;
  final sourceGoalId = await selectTaskDialog(destinationGoal.goalsForLocalImport.sorted(sortByDateAsc), loc.task_transfer_source_hint);

  if (sourceGoalId != null) {
    final sourceGoal = destinationGoal.goalsForLocalImport.firstWhere((g) => g.id == sourceGoalId);

    await showMTDialog<void>(
      TasksLocalImportDialog(
        LocalImportController(
          sourceGoal,
          taskController,
        ),
      ),
    );
  }
}

class TasksLocalImportDialog extends StatelessWidget {
  const TasksLocalImportDialog(this.controller);
  final LocalImportController controller;

  Task get _srcGoal => controller.sourceGoal;
  Task get _dstGoal => controller.destinationGoal;

  bool get _showSelectAll => controller.srcTasks.length > 2;

  Widget _taskItem(BuildContext context, int index) {
    final _t = controller.srcTasks[index];
    return MTCheckBoxTile(
      title: _t.title,
      description: _t.description,
      value: controller.checks[index] == true,
      bottomBorder: index < controller.checks.length - 1,
      onChanged: (bool? value) => controller.selectTask(index, value),
    );
  }

  Widget _addressLine(String label, String title) => MTListTile(
        leading: LightText(label, color: lightGreyColor),
        titleText: title,
        color: backgroundColor,
        bottomDivider: false,
        padding: const EdgeInsets.symmetric(horizontal: P + P_2),
      );

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTDialog(
          topBar: MTTopBar(
            middle: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MediumText(loc.task_transfer_title),
                const SizedBox(height: P),
                _addressLine(loc.task_transfer_source_label, '$_srcGoal'),
                _addressLine(loc.task_transfer_destination_label, '$_dstGoal'),
                if (_showSelectAll)
                  MTCheckBoxTile(
                    title: '${loc.select_all_action_title} (${controller.checks.length})',
                    titleColor: mainColor,
                    color: backgroundColor,
                    bottomBorder: true,
                    value: controller.selectedAll,
                    onChanged: controller.toggleSelectedAll,
                  )
                else
                  const SizedBox(height: P),
              ],
            ),
          ),
          topBarHeight: P * 9 + (P * (_showSelectAll ? 3 : 0)),
          body: MTShadowed(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _taskItem,
              itemCount: controller.checks.length,
            ),
          ),
          bottomBar: MTButton.main(
            leading: LocalImportIcon(color: controller.validated ? lightBackgroundColor : greyTextColor),
            titleText: loc.task_transfer_import_confirm_action_title,
            onTap: controller.validated ? controller.moveTasks : null,
          ),
        ),
      );
}
