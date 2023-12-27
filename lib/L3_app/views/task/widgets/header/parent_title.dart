// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/field.dart';
import '../../../../components/text.dart';
import '../../../../extra/router.dart';
import '../../../../usecases/task_tree.dart';
import '../../controllers/task_controller.dart';
import '../../task_view.dart';

class TaskParentTitle extends StatelessWidget {
  const TaskParentTitle(this._controller);
  final TaskController _controller;

  Task get _task => _controller.task!;

  Future _toParent(BuildContext context) async {
    final parent = _task.parent!;
    (MTRouter.routerForType(TaskRouter) as TaskRouter).navigateBreadcrumbs(context, parent);
  }

  @override
  Widget build(BuildContext context) {
    return MTField(
      _controller.fData(TaskFCode.parent.index),
      value: BaseText(_task.parent!.title, maxLines: 1, color: mainColor),
      padding: const EdgeInsets.symmetric(horizontal: P3),
      color: Colors.transparent,
      minHeight: P4,
      onTap: () => _toParent(context),
    );
  }
}
