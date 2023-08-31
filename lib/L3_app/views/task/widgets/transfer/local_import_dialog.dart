// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/usecases/task_comparators.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../../../presenters/task_transfer.dart';
import '../../controllers/local_import_controller.dart';
import '../../controllers/task_controller.dart';
import 'select_task_dialog.dart';

Future localImportDialog(TaskController taskController) async {
  final destinationGoal = taskController.task;
  final sourceGoalId = await selectTaskDialog(destinationGoal.goalsForLocalImport.sorted(sortByDateAsc), loc.task_transfer_source_hint);

  if (sourceGoalId != null) {
    final sourceGoal = destinationGoal.goalsForLocalImport.firstWhere((g) => g.id == sourceGoalId);

    await showMTDialog<void>(
      LocalImportDialog(
        LocalImportController(sourceGoal, taskController),
      ),
    );
  }
}

class LocalImportDialog extends StatelessWidget {
  const LocalImportDialog(this.controller);
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
        leading: BaseText.f2(label),
        middle: BaseText(title, maxLines: 1),
        color: b2Color,
        bottomDivider: false,
        padding: const EdgeInsets.symmetric(horizontal: P3),
      );

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTDialog(
          topBar: MTTopBar(
            middle: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText.medium(loc.task_transfer_title),
                const SizedBox(height: P),
                _addressLine(loc.task_transfer_source_label, '$_srcGoal'),
                _addressLine(loc.task_transfer_destination_label, '$_dstGoal'),
                if (_showSelectAll)
                  MTCheckBoxTile(
                    title: '${loc.select_all_action_title} (${controller.checks.length})',
                    titleColor: mainColor,
                    color: b2Color,
                    bottomBorder: true,
                    value: controller.selectedAll,
                    onChanged: controller.toggleSelectedAll,
                  )
                else
                  const SizedBox(height: P2),
              ],
            ),
          ),
          topBarHeight: P * 17 + (P2 * (_showSelectAll ? 3 : 0)),
          body: MTShadowed(
            bottomShadow: true,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _taskItem,
              itemCount: controller.checks.length,
            ),
          ),
          bottomBar: MTButton.main(
            leading: LocalImportIcon(color: controller.validated ? mainBtnTitleColor : f2Color),
            titleText: loc.task_transfer_import_confirm_action_title,
            onTap: controller.validated ? controller.moveTasks : null,
          ),
        ),
      );
}
