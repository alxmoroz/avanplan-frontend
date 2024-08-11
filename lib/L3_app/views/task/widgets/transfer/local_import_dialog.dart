// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
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
  await lic.selectSourceForMove();
  if (lic.srcSelected) {
    await showMTDialog<void>(_LocalImportDialog(lic));
  }
}

class _LocalImportDialog extends StatelessWidget {
  const _LocalImportDialog(this.controller);
  final LocalImportController controller;

  Task? get _src => controller.srcGroup;
  Task get _dst => controller.dstGroup;

  bool get _showSelectAll => controller.srcTasks.length > 2;

  Widget _taskItem(BuildContext context, int index) {
    final t = controller.srcTasks[index];
    return MTCheckBoxTile(
      title: t.title,
      description: t.description,
      value: controller.checks[index] == true,
      bottomDivider: index < controller.checks.length - 1,
      onChanged: (bool? value) => controller.checkTask(index, value),
    );
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTDialog(
          topBar: MTAppBar(
            showCloseButton: true,
            color: b2Color,
            title: loc.task_transfer_title,
            innerHeight: P * 22 + (_showSelectAll ? P8 : P),
            bottom: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: P3,
                  alignment: Alignment.center,
                  child: BaseText(
                    '$_dst',
                    maxLines: 1,
                    align: TextAlign.center,
                    padding: const EdgeInsets.symmetric(horizontal: P2),
                  ),
                ),
                const SizedBox(height: P),
                MTButton.secondary(
                  constrained: false,
                  padding: const EdgeInsets.symmetric(horizontal: P3),
                  margin: const EdgeInsets.symmetric(horizontal: P2),
                  titleText: controller.srcSelected ? '$_src' : loc.task_transfer_source_hint,
                  trailing: controller.srcSelected
                      ? const Padding(
                          padding: EdgeInsets.only(top: P_2),
                          child: CaretIcon(size: Size(P2 * 0.7, P2 * 0.7), color: mainColor),
                        )
                      : null,
                  onTap: controller.selectSourceForMove,
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
          body: MTShadowed(
            topPaddingIndent: 0,
            shadowColor: b1Color,
            bottomShadow: controller.srcSelected,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _taskItem,
              itemCount: controller.checks.length,
            ),
          ),
          bottomBar: controller.srcSelected
              ? MTAppBar(
                  isBottom: true,
                  inDialog: true,
                  color: b2Color,
                  padding: EdgeInsets.only(top: P2, bottom: MediaQuery.paddingOf(context).bottom == 0 ? P3 : 0),
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
