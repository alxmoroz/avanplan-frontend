// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/colors.dart';
import '../../../../components/colors_base.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/text.dart';
import '../../../../components/toolbar.dart';
import '../../../../extra/services.dart';
import '../../controllers/task_controller.dart';
import 'local_import_controller.dart';

Future localImportDialog(TaskController taskController) async {
  final lic = LocalImportController(taskController);
  await lic.selectSourceGoal();
  if (lic.sourceSelected) {
    await showMTDialog<void>(LocalImportDialog(lic));
  }
}

class LocalImportDialog extends StatelessWidget {
  const LocalImportDialog(this.controller);
  final LocalImportController controller;

  Task? get _srcGoal => controller.sourceGoal;
  Task get _dstGoal => controller.destinationGoal;

  bool get _showSelectAll => controller.srcTasks.length > 2;

  Widget _taskItem(BuildContext context, int index) {
    final _t = controller.srcTasks[index];
    return MTCheckBoxTile(
      title: _t.title,
      description: _t.description,
      value: controller.checks[index] == true,
      bottomDivider: index < controller.checks.length - 1,
      onChanged: (bool? value) => controller.checkTask(index, value),
    );
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTDialog(
          topBar: MTToolBar(
            titleText: loc.task_transfer_title,
            bottom: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BaseText(
                  '$_dstGoal',
                  maxLines: 1,
                  align: TextAlign.center,
                  padding: const EdgeInsets.symmetric(horizontal: P2).copyWith(bottom: P),
                ),
                MTButton.secondary(
                  constrained: false,
                  padding: const EdgeInsets.symmetric(horizontal: P3),
                  margin: const EdgeInsets.symmetric(horizontal: P2),
                  middle: Flexible(
                    child: BaseText.medium(
                      controller.sourceSelected ? '$_srcGoal' : loc.task_transfer_source_hint,
                      maxLines: 1,
                      color: mainColor,
                    ),
                  ),
                  trailing: controller.sourceSelected
                      ? const Padding(
                          padding: EdgeInsets.only(top: P_2),
                          child: CaretIcon(size: Size(P2 * 0.7, P2 * 0.7), color: mainColor),
                        )
                      : null,
                  onTap: controller.selectSourceGoal,
                ),
                if (_showSelectAll)
                  MTCheckBoxTile(
                    title: '${loc.select_all_action_title} (${controller.checks.length})',
                    titleColor: mainColor,
                    color: b2Color,
                    value: controller.selectedAll,
                    bottomDivider: false,
                    onChanged: controller.toggleAll,
                  )
                else
                  const SizedBox(height: P),
              ],
            ),
          ),
          topBarHeight: P * 20.5 + (_showSelectAll ? P8 : 0),
          body: MTShadowed(
            topPaddingIndent: 0,
            shadowColor: b1Color,
            bottomShadow: controller.sourceSelected,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _taskItem,
              itemCount: controller.checks.length,
            ),
          ),
          bottomBar: controller.sourceSelected
              ? MTAppBar(
                  isBottom: true,
                  paddingBottom: isBigScreen ? P2 : null,
                  bgColor: b2Color,
                  middle: MTButton.main(
                    leading: LocalImportIcon(color: controller.validated ? mainBtnTitleColor : f2Color),
                    titleText: loc.task_transfer_import_confirm_action_title,
                    onTap: controller.validated ? controller.moveTasks : null,
                  ),
                )
              : null,
        ),
      );
}
