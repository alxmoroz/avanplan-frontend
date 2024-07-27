// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../components/adaptive.dart';
import '../../components/constants.dart';
import '../../extra/route.dart';
import '../../extra/router.dart';
import '../../presenters/task_type.dart';
import '../../usecases/task_tree.dart';
import '../quiz/abstract_task_quiz_controller.dart';
import 'controllers/create_goal_quiz_controller.dart';
import 'controllers/create_project_quiz_controller.dart';
import 'controllers/task_controller.dart';
import 'task_view.dart';
import 'widgets/create/create_subtasks_quiz_view.dart';
import 'widgets/create/create_task_quiz_view.dart';
import 'widgets/empty_state/task_404_dialog.dart';
import 'widgets/project_modules/project_modules.dart';
import 'widgets/team/team_quiz_view.dart';

abstract class BaseTaskRoute extends MTRoute {
  BaseTaskRoute({
    required super.baseName,
    super.parent,
  }) : super(controller: TaskController());

  bool get _parentHasWsId => parent is BaseTaskRoute && (parent as BaseTaskRoute)._hasWsId == true;
  bool get _hasWsId => path.contains(':wsId') || _parentHasWsId;

  @override
  String get path => '${!_parentHasWsId ? 'ws_:wsId/' : ''}${baseName}_:${baseName}Id';

  @override
  double get dialogMaxWidth => SCR_L_WIDTH;

  @override
  String title(GoRouterState state) => _td.viewTitle;

  @override
  bool isDialog(BuildContext context) => isBigScreen(context) && baseName == TType.TASK.toLowerCase();

  TaskController get _tc => controller as TaskController;
  Task get _td => _tc.taskDescriptor;

  @override
  GoRouterRedirect? get redirect => (context, state) {
        final wsId = state.pathParamInt('wsId')!;
        final taskId = state.pathParamInt('${baseName}Id')!;
        _tc.init(wsId, taskId, type: baseName.toUpperCase(), route: this);

        return null;
      };

  @override
  GoRouterWidgetBuilder? get builder => (_, state) {
        // шаг квиза?
        AbstractTaskQuizController? qc = (state.extra is AbstractTaskQuizController) ? state.extra as AbstractTaskQuizController : null;
        if (qc == null && _td.creating && (_td.isProject || _td.isGoal)) {
          qc = _td.isProject ? CreateProjectQuizController(_tc) : CreateGoalQuizController(_tc);
        }
        final qcTask = qc?.taskController.taskDescriptor;

        return qc != null && (qcTask == _td || qcTask == _td.parent)
            ? CreateTaskQuizView(_tc, qc)
            : TaskView(
                _tc,
                key: state.pageKey,
              );
      };
}

class TaskRoute extends BaseTaskRoute {
  static String get staticBaseName => TType.TASK.toLowerCase();

  TaskRoute({super.parent}) : super(baseName: staticBaseName);
}

class GoalRoute extends BaseTaskRoute {
  static String get staticBaseName => TType.GOAL.toLowerCase();

  GoalRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  List<RouteBase> get routes => [
        CreateSubtasksQuizRoute(parent: this),
        TaskRoute(parent: this),
        Task404Route(parent: this),
      ];
}

class BacklogRoute extends BaseTaskRoute {
  static String get staticBaseName => TType.BACKLOG.toLowerCase();

  BacklogRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  List<RouteBase> get routes => [
        TaskRoute(parent: this),
        Task404Route(parent: this),
      ];
}

class InboxRoute extends BaseTaskRoute {
  static String get staticBaseName => TType.INBOX.toLowerCase();

  InboxRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  List<RouteBase> get routes => [
        TaskRoute(parent: this),
        Task404Route(parent: this),
      ];
}

class ProjectRoute extends BaseTaskRoute {
  static String get staticBaseName => TType.PROJECT.toLowerCase();

  ProjectRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  List<RouteBase> get routes => [
        ProjectModulesQuizRoute(parent: this),
        TeamQuizRoute(parent: this),
        CreateSubtasksQuizRoute(parent: this),
        GoalRoute(parent: this),
        BacklogRoute(parent: this),
        TaskRoute(parent: this),
        Task404Route(parent: this),
      ];
}
