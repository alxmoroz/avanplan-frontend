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
import '../../../../components/limit_badge.dart';
import '../../../../presenters/task_type.dart';
import '../../../../usecases/ws_actions.dart';
import '../../../../usecases/ws_tasks.dart';
import '../../controllers/onboarding_controller.dart';
import '../../controllers/task_controller.dart';
import '../../task_onboarding_view.dart';

class TaskCreateButton extends StatelessWidget {
  const TaskCreateButton(
    this._ws, {
    TaskController? parentTaskController,
    bool compact = false,
    bool dismissible = false,
  })  : _parentTaskController = parentTaskController,
        _compact = compact,
        _dismissible = dismissible;

  final TaskController? _parentTaskController;
  final bool _compact;
  final bool _dismissible;
  final Workspace _ws;
  Task? get _parent => _parentTaskController?.task;

  Widget get _plusIcon => const PlusIcon(color: mainBtnTitleColor);

  @override
  Widget build(BuildContext context) {
    // TODO: вынести логику в какой-нибудь контроллер

    Future _tap() async {
      if (_dismissible && Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
      final newTask = await _ws.createTask(_parent);
      if (newTask != null) {
        final tc = TaskController(newTask);
        if (newTask.isProject) {
          await tc.showOnboardingTask(TaskOnboardingView.routeNameProject, context, OnboardingController(tc));
        } else {
          await tc.showTask();
          if (_parentTaskController != null) {
            _parentTaskController!.selectTab(TaskTabKey.subtasks);
          }
        }
      }
    }

    final badge = MTLimitBadge(
      margin: EdgeInsets.only(right: _compact ? P3 : 0),
      showBadge: !_ws.plCreate(_parent),
      child: MTButton.main(
        leading: _compact ? null : _plusIcon,
        titleText: _compact ? null : newSubtaskTitle(_parent),
        middle: _compact ? _plusIcon : null,
        constrained: false,
        onTap: _tap,
      ),
    );

    return _compact ? badge : MTAdaptive.xxs(child: badge);
  }
}
