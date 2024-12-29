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
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import 'local_import_controller.dart';

Future localImportDialog(TaskController tc) async {
  final lic = LocalImportController(tc);
  await lic.selectSourceForMove();
  if (lic.srcSelected) {
    await showMTDialog(_LocalImportDialog(lic));
  }
}

class _LocalImportDialog extends StatelessWidget {
  const _LocalImportDialog(this._lic);
  final LocalImportController _lic;

  Task? get _src => _lic.srcGroup;
  Task get _dst => _lic.dstGroup;

  bool get _showSelectAll => _lic.srcTasks.length > 2;

  Widget _taskItem(BuildContext context, int index) {
    final t = _lic.srcTasks[index];
    return MTCheckBoxTile(
      title: t.title,
      description: t.description,
      value: _lic.checks[index] == true,
      bottomDivider: index < _lic.checks.length - 1,
      onChanged: (bool? value) => _lic.checkTask(index, value),
    );
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTDialog(
          topBar: MTTopBar(
            pageTitle: loc.transfer_tasks_title,
            parentPageTitle: _dst.title,
            innerHeight: P * 14 + (_lic.singleSourceFlag ? 0 : P5) + (_showSelectAll ? P8 : 0),
            bottomWidget: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MTListTile(
                  middle: BaseText.medium(_lic.srcSelected ? '$_src' : loc.transfer_select_source_hint, color: f2Color, maxLines: 1),
                  trailing: SizedBox(
                    width: P4,
                    child: Align(child: CaretIcon(size: const Size(P2, P2), color: _lic.singleSourceFlag ? f3Color : mainColor)),
                  ),
                  margin: EdgeInsets.only(top: _lic.singleSourceFlag ? 0 : P),
                  padding: EdgeInsets.symmetric(vertical: _lic.singleSourceFlag ? 0 : P2, horizontal: P3),
                  color: _lic.singleSourceFlag ? Colors.transparent : null,
                  bottomDivider: false,
                  onTap: _lic.singleSourceFlag ? null : _lic.selectSourceForMove,
                ),
                if (_showSelectAll)
                  MTCheckBoxTile(
                    title: '${loc.action_select_all_title} (${_lic.checks.length})',
                    titleColor: mainColor,
                    color: b2Color,
                    value: _lic.selectedAll,
                    bottomDivider: false,
                    onChanged: _lic.toggleAll,
                  )
              ],
            ),
          ),
          body: MTShadowed(
            bottomShadow: _lic.srcSelected,
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _taskItem,
              itemCount: _lic.checks.length,
            ),
          ),
          bottomBar: _lic.srcSelected
              ? MTBottomBar(
                  middle: MTButton.main(
                    leading: LocalImportIcon(color: _lic.validated ? mainBtnTitleColor : f2Color),
                    titleText: loc.action_transfer_title,
                    onTap: _lic.validated ? _lic.moveTasks : null,
                  ),
                )
              : null,
        ),
      );
}
