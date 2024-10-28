// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/button.dart';
import '../../../../components/checkbox.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
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
    await showMTDialog(_LocalImportDialog(lic));
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
          topBar: MTTopBar(
            pageTitle: loc.task_transfer_title,
            parentPageTitle: _dst.title,
            innerHeight: P * 19 + (_showSelectAll ? P8 : 0),
            bottomWidget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MTListTile(
                  middle: BaseText.medium(
                    controller.srcSelected ? '$_src' : loc.task_transfer_source_hint,
                    color: f2Color,
                    maxLines: 1,
                  ),
                  trailing: const SizedBox(
                    width: P4,
                    child: Align(child: CaretIcon(size: Size(P2, P2), color: mainColor)),
                  ),
                  margin: const EdgeInsets.only(top: P),
                  bottomDivider: false,
                  onTap: controller.selectSourceForMove,
                ),
                if (_showSelectAll)
                  MTCheckBoxTile(
                    title: '${loc.action_select_all_title} (${controller.checks.length})',
                    titleColor: mainColor,
                    color: b2Color,
                    value: controller.selectedAll,
                    bottomDivider: false,
                    onChanged: controller.toggleAll,
                  )
              ],
            ),
          ),
          body: MTShadowed(
            bottomShadow: controller.srcSelected,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _taskItem,
              itemCount: controller.checks.length,
            ),
          ),
          bottomBar: controller.srcSelected
              ? MTBottomBar(
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
