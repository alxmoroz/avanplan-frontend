// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities_extensions/task_relation.dart';
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
  const _CreateRelationDialog(this.crc);
  final CreateRelationsController crc;

  Task? get _dstGroup => crc.dstGroup;

  Widget _taskItem(BuildContext context, int index) {
    final t = crc.dstTasks[index];
    final isRelated = crc.task.isRelated(t.id!);
    return TaskCard(
      t,
      bottomDivider: index < crc.dstTasks.length - 1,
      trailing: isRelated ? const DoneIcon(true, circled: false, size: P3, color: f3Color) : const LinkIcon(size: P4),
      readOnly: isRelated,
      onTap: crc.createRelation,
    );
  }

  @override
  Widget build(BuildContext context) => Observer(
        builder: (_) => MTDialog(
          topBar: MTTopBar(
            pageTitle: loc.relation_create_dialog_title,
            parentPageTitle: crc.task.title,
            innerHeight: P * 19,
            bottomWidget: MTListTile(
              margin: const EdgeInsets.only(top: P),
              middle: BaseText.medium(crc.dstSelected ? '$_dstGroup' : loc.task_transfer_source_hint, maxLines: 1, color: f2Color),
              trailing: const SizedBox(
                width: P4,
                child: Align(child: CaretIcon(size: Size(P2, P2), color: mainColor)),
              ),
              bottomDivider: false,
              onTap: crc.selectDstGroup,
            ),
          ),
          body: MTShadowed(
            child: ListView.builder(
              shrinkWrap: true,
              itemBuilder: _taskItem,
              itemCount: crc.dstTasks.length,
            ),
          ),
        ),
      );
}
