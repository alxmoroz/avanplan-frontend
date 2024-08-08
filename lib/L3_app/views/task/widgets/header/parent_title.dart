// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L2_data/services/platform.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../extra/router.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';

class TaskParentTitle extends StatelessWidget {
  const TaskParentTitle(this._controller, {super.key});
  final TaskController _controller;

  Task get _task => _controller.task;

  void _toParent() {
    router.pop();
    router.goTaskView(_task.parent!, direct: true);
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTField(
        _controller.fData(TaskFCode.parent.index),
        value: BaseText(_task.parent!.title, maxLines: 1, color: mainColor),
        padding: const EdgeInsets.only(left: 1),
        margin: EdgeInsets.only(bottom: isWeb ? P2 : 0),
        color: Colors.transparent,
        minHeight: P6,
        onTap: _toParent,
      ),
    );
  }
}
