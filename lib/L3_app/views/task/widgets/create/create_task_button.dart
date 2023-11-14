// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_tree.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../usecases/ws_tasks.dart';
import '../../controllers/create_goal_quiz_controller.dart';
import '../../controllers/task_controller.dart';
import 'create_task_quiz_view.dart';

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton(
    TaskController parentTaskController, {
    bool compact = false,
    bool uf = true,
    EdgeInsets? margin,
    ButtonType? type,
    Function()? onTap,
  })  : _parentTaskController = parentTaskController,
        _compact = compact,
        _margin = margin,
        _uf = uf,
        _onTap = onTap,
        _type = type;

  final TaskController _parentTaskController;
  final bool _compact;
  final bool _uf;
  final EdgeInsets? _margin;
  final ButtonType? _type;
  final Function()? _onTap;

  Workspace get _ws => _parent.ws;
  Task get _parent => _parentTaskController.task;

  Widget get _plusIcon => PlusIcon(color: _type == ButtonType.secondary ? mainColor : mainBtnTitleColor);

  Future _tap(BuildContext context) async {
    final newTask = await _ws.createTask(_parent);
    if (newTask != null) {
      final tc = TaskController(newTask, isNew: true);
      if (newTask.isGoal) {
        await CreateGoalQuizViewRouter().navigate(context, args: CreateTaskQuizArgs(tc, CreateGoalQuizController(tc)));
      } else {
        await tc.showTask();
      }
      _parentTaskController.selectTab(TaskTabKey.subtasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MTBadgeButton(
      margin: _margin ?? EdgeInsets.only(right: _compact ? P3 : 0),
      showBadge: !_ws.plCreate(_parent),
      type: _type ?? ButtonType.main,
      leading: _compact ? null : _plusIcon,
      titleText: _compact ? null : addSubtaskActionTitle(_parent),
      middle: _compact ? _plusIcon : null,
      constrained: !_compact,
      uf: _uf,
      onTap: _onTap != null ? _onTap : () => _tap(context),
    );
  }
}
