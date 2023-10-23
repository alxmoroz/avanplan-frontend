// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/limit_badge.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../usecases/ws_tasks.dart';
import '../../controllers/task_controller.dart';

class TaskCreateButton extends StatelessWidget {
  const TaskCreateButton(
    TaskController parentTaskController, {
    bool compact = false,
  })  : _parentTaskController = parentTaskController,
        _compact = compact;

  final TaskController _parentTaskController;
  final bool _compact;
  Workspace get _ws => _parent.ws;
  Task get _parent => _parentTaskController.task;

  Widget get _plusIcon => const PlusIcon(color: mainBtnTitleColor);

  Future _tap(BuildContext context) async {
    final newTask = await _ws.createTask(_parent);
    if (newTask != null) {
      final tc = TaskController(newTask);
      await tc.showTask();
      _parentTaskController.selectTab(TaskTabKey.subtasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    final badge = MTLimitBadge(
      margin: EdgeInsets.only(right: _compact ? P3 : 0),
      showBadge: !_ws.plCreate(_parent),
      child: MTButton.main(
        leading: _compact ? null : _plusIcon,
        titleText: _compact ? null : addSubtaskActionTitle(_parent),
        middle: _compact ? _plusIcon : null,
        constrained: false,
        onTap: () => _tap(context),
      ),
    );

    return _compact ? badge : MTAdaptive.xxs(child: badge);
  }
}
