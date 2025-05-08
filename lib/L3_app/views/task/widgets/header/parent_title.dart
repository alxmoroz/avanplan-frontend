// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../navigation/router.dart';
import '../../../../presenters/task_tree.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/text.dart';
import '../../controllers/task_controller.dart';

class TaskParentTitle extends StatelessWidget {
  const TaskParentTitle(this._tc, {super.key});
  final TaskController _tc;

  // TODO: поправить тут с учётом goTaskFromTask и др. кода в нашем роутере.
  //  Проблема в том, что подряд две строчки эти не работают корректно. Только в изоляции друг от друга.
  void _toParent(Task parent) {
    router.pop();
    router.goTask(parent, direct: true);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final t = _tc.task;
      final parent = t.parent!;
      return MTField(
        _tc.fData(TaskFCode.parent.index),
        value: BaseText(parent.title, maxLines: 1, color: _tc.isPreview ? f3Color : mainColor),
        padding: const EdgeInsets.only(left: 1),
        color: Colors.transparent,
        minHeight: P7,
        onTap: _tc.isPreview ? null : () => _toParent(parent),
      );
    });
  }
}
