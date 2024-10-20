// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/icons.dart';
import '../../../../components/text.dart';
import '../../controllers/relations_controller.dart';
import '../../controllers/task_controller.dart';
import 'relations_dialog.dart';

class TaskRelationsField extends StatelessWidget {
  const TaskRelationsField(this._controller, {super.key, this.hasMargin = false});

  final TaskController _controller;
  final bool hasMargin;
  RelationsController get _rc => _controller.relationsController;

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.relation.index),
      margin: EdgeInsets.only(top: hasMargin ? P3 : 0),
      leading: const LinkIcon(size: P6),
      value: Row(children: [
        Flexible(child: BaseText(_rc.relationsStr, maxLines: 1)),
        if (_rc.relationsCountMoreStr.isNotEmpty)
          BaseText.f2(
            _rc.relationsCountMoreStr,
            maxLines: 1,
            padding: const EdgeInsets.only(left: P),
          )
      ]),
      onTap: () => relationsDialog(_rc),
    );
  }
}
