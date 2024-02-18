// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../../L1_domain/entities/task.dart';
import '../../../../../L1_domain/entities/workspace.dart';
import '../../../../../L1_domain/entities_extensions/task_tree.dart';
import '../../../../components/adaptive.dart';
import '../../../../components/button.dart';
import '../../../../components/colors.dart';
import '../../../../components/constants.dart';
import '../../../../components/icons.dart';
import '../../../../components/list_tile.dart';
import '../../../../components/text.dart';
import '../../../../extra/router.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/task_tree.dart';
import '../../../../usecases/ws_tasks.dart';
import '../../controllers/create_goal_quiz_controller.dart';
import '../../controllers/task_controller.dart';
import 'create_task_quiz_view.dart';

class CreateTaskButton extends StatelessWidget {
  const CreateTaskButton(
    TaskController parentTaskController, {
    super.key,
    bool compact = false,
    EdgeInsets? margin,
    ButtonType? type,
    Function()? onTap,
  })  : _parentTaskController = parentTaskController,
        _type = type,
        _compact = compact,
        _margin = margin,
        _onTap = onTap;

  final TaskController _parentTaskController;
  final bool _compact;
  final EdgeInsets? _margin;
  final ButtonType? _type;
  final Function()? _onTap;

  Workspace get _ws => _parent.ws;
  Task get _parent => _parentTaskController.task!;

  Widget _plusIcon(BuildContext context) => PlusIcon(
        color: _type == ButtonType.main ? mainBtnTitleColor : mainColor,
        size: _type != null ? P4 : P6,
        circled: isBigScreen(context) && _type == null,
      );

  Future _tap(BuildContext context) async {
    if (_onTap != null) {
      _onTap!();
    } else {
      final newTask =
          await _ws.createTask(_parent, statusId: _parent.isProject ? null : _parentTaskController.projectStatusesController.firstOpenedStatusId);
      if (newTask != null) {
        final tc = TaskController(newTask, isNew: true);
        if (newTask.isGoal) {
          if (context.mounted) {
            await MTRouter.navigate(CreateGoalQuizRouter, context, args: CreateTaskQuizArgs(tc, CreateGoalQuizController(tc)));
          }
        } else {
          await tc.showTask();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final plusIcon = _plusIcon(context);
    return isBigScreen(context) && _type == null
        ? MTListTile(
            leading: plusIcon,
            middle: !_compact ? BaseText(addSubtaskActionTitle(_parent), maxLines: 1, color: mainColor) : null,
            bottomDivider: false,
            onTap: () => _tap(context),
          )
        : MTButton(
            leading: _compact ? null : plusIcon,
            margin: _margin,
            type: _type ?? ButtonType.main,
            titleText: _compact ? null : addSubtaskActionTitle(_parent),
            middle: _compact ? plusIcon : null,
            constrained: !_compact,
            onTap: () => _tap(context),
          );
  }
}
