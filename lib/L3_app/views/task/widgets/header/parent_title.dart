// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../navigation/router.dart';
import '../../../../presenters/task_tree.dart';
import '../../controllers/task_controller.dart';

class TaskParentTitle extends StatelessWidget {
  const TaskParentTitle(this._tc, {super.key});
  final TaskController _tc;

  Task get _t => _tc.task;

  // TODO: поправить тут с учётом goTaskFromTask и др. кода в нашем роутере.
  //  Проблема в том, что подряд две строчки эти не работают корректно. Только в изоляции друг от друга.
  void _toParent() {
    router.pop();
    router.goTask(_t.parent!, direct: true);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTField(
        _tc.fData(TaskFCode.parent.index),
        value: BaseText(_t.parent!.title, maxLines: 1, color: _tc.isPreview ? f3Color : mainColor),
        padding: const EdgeInsets.only(left: 1),
        color: Colors.transparent,
        minHeight: P7,
        onTap: _tc.isPreview ? null : _toParent,
      ),
    );
  }
}
