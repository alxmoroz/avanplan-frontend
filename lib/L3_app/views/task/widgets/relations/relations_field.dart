// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../controllers/relations_controller.dart';
import '../../controllers/task_controller.dart';
import 'relations_dialog.dart';

class TaskRelationsField extends StatelessWidget {
  const TaskRelationsField(this._tc, {super.key, this.hasMargin = false});

  final TaskController _tc;
  final bool hasMargin;

  RelationsController get _rc => _tc.relationsController;

  @override
  Widget build(BuildContext context) {
    final canEdit = _tc.canEditRelations;

    return MTField(
      _tc.fData(TaskFCode.relation.index),
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      leading: LinkIcon(size: DEF_TAPPABLE_ICON_SIZE, color: canEdit ? mainColor : f3Color),
      value: _rc.hasRelations
          ? Row(children: [
              Flexible(child: BaseText(_rc.relationsStr, maxLines: 1, color: canEdit ? null : f2Color)),
              if (_rc.relationsCountMoreStr.isNotEmpty)
                BaseText.f2(
                  _rc.relationsCountMoreStr,
                  maxLines: 1,
                  padding: const EdgeInsets.only(left: P),
                )
            ])
          : null,
      onTap: canEdit ? () => relationsDialog(_rc) : null,
    );
  }
}
