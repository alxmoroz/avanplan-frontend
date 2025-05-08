// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_relation.dart';
import '../../../../components/constants.dart';
import '../../../../components/dialog.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/shadowed.dart';
import '../../../../components/toolbar.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../../app/services.dart';
import '../../controllers/task_controller.dart';
import '../tasks/card.dart';
import 'create_relations_controller.dart';

Future createRelationDialog(TaskController tc) async {
  final crc = CreateRelationsController(tc);
  await crc.selectDstGroup();
  if (crc.dstSelected) {
    await showMTDialog(_CreateRelationDialog(crc));
  }
}

class _CreateRelationDialog extends StatelessWidget {
  const _CreateRelationDialog(this._crc);
  final CreateRelationsController _crc;

  Task? get _dstGroup => _crc.dstGroup;

  Widget _taskItem(BuildContext context, int index) {
    final t = _crc.dstTasks[index];
    final isRelated = _crc.srcTask.isRelated(t.id!);
    return TaskCard(
      t,
      bottomDivider: index < _crc.dstTasks.length - 1,
      trailing: isRelated ? const LinkIcon(color: f3Color) : const SizedBox(),
      readOnly: isRelated,
      onTap: _crc.createRelation,
    );
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTDialog(
          topBar: MTTopBar(
            pageTitle: loc.relation_create_dialog_title,
            parentPageTitle: _crc.srcTask.title,
            innerHeight: P * 14 + (_crc.singleSourceFlag ? 0 : P5),
            bottomWidget: MTListTile(
              middle: BaseText.medium(_crc.dstSelected ? '$_dstGroup' : loc.transfer_select_source_hint, maxLines: 1, color: f2Color),
              trailing: SizedBox(
                width: P4,
                child: Align(child: CaretIcon(size: const Size(P2, P2), color: _crc.singleSourceFlag ? f3Color : mainColor)),
              ),
              margin: EdgeInsets.only(top: _crc.singleSourceFlag ? 0 : P),
              padding: EdgeInsets.symmetric(vertical: _crc.singleSourceFlag ? 0 : P2, horizontal: P3),
              color: _crc.singleSourceFlag ? Colors.transparent : b3Color,
              bottomDivider: false,
              onTap: _crc.singleSourceFlag ? null : _crc.selectDstGroup,
            ),
          ),
          body: MTShadowed(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _taskItem,
              itemCount: _crc.dstTasks.length,
            ),
          ),
        ),
      );
}
