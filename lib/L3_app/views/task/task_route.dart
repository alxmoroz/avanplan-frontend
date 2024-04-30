// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../components/adaptive.dart';
import '../../components/constants.dart';
import '../../extra/route.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/task_type.dart';
import '../main/main_view.dart';
import 'task_view.dart';
import 'widgets/create/create_subtasks_quiz_view.dart';
import 'widgets/create/create_task_quiz_view.dart';
import 'widgets/empty_state/not_found_dialog.dart';
import 'widgets/feature_sets/feature_sets.dart';
import 'widgets/team/team_quiz_view.dart';

abstract class BaseTaskRoute extends MTRoute {
  BaseTaskRoute({
    required super.baseName,
    super.parent,
  });

  bool get _parentHasWsId => parent is BaseTaskRoute && (parent as BaseTaskRoute).hasWsId == true;
  bool get hasWsId => path.contains(':wsId') || _parentHasWsId;

  @override
  String get path => '${!_parentHasWsId ? 'ws_:wsId/' : ''}${baseName}_:${baseName}Id';

  @override
  double get dialogMaxWidth => SCR_L_WIDTH;

  @override
  String? title(GoRouterState state) {
    final t = task(state);
    return t != null ? t.viewTitle : loc.error_404_task_title;
  }

  @override
  bool isDialog(BuildContext context) => isBigScreen(context) && baseName == TType.TASK.toLowerCase();

  Task? task(GoRouterState state) {
    final wsId = state.intPathParam('wsId');
    final taskId = state.intPathParam('${baseName}Id');
    return wsId != null && taskId != null ? tasksMainController.task(wsId, taskId) : null;
  }

  @override
  GoRouterRedirect? get redirect =>
      (_, state) => task(state) != null ? null : router.namedLocation('${mainRoute.name}/${TaskNotFoundRoute.staticBaseName}');

  @override
  GoRouterWidgetBuilder? get builder => (context, state) {
        final t = task(state)!;
        final isNew = state.extra != null;
        if (isNew && (t.isProject || t.isGoal)) {
          return CreateTaskQuizView(t);
        }
        return TaskView(t, isNew: isNew);
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
      ];
}

class BacklogRoute extends BaseTaskRoute {
  static String get staticBaseName => TType.BACKLOG.toLowerCase();

  BacklogRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  List<RouteBase> get routes => [TaskRoute(parent: this)];
}

class InboxRoute extends BaseTaskRoute {
  static String get staticBaseName => TType.INBOX.toLowerCase();

  InboxRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  List<RouteBase> get routes => [TaskRoute(parent: this)];
}

class ProjectRoute extends BaseTaskRoute {
  static String get staticBaseName => TType.PROJECT.toLowerCase();

  ProjectRoute({super.parent}) : super(baseName: staticBaseName);

  @override
  List<RouteBase> get routes => [
        FeatureSetsQuizRoute(parent: this),
        TeamQuizRoute(parent: this),
        CreateSubtasksQuizRoute(parent: this),
        GoalRoute(parent: this),
        BacklogRoute(parent: this),
        TaskRoute(parent: this),
      ];
}

// Future navigateBreadcrumbs(BuildContext context, Task parent) async {
//   final pName = (prevName ?? '');
//
//   // переходим один раз назад в любом случае
//   context.pop();
//
//   // если переход был с главной то нужно запушить родителя
//   final fromRoots = !pName.startsWith('/ws/');
//   if (fromRoots) {
//     await push(context, args: TaskController(parent));
//   } else {
//     // при переходе наверх в другую цель, меняем старого родителя на нового
//     if (parent.isGoal) {
//       final previousGoalId = int.parse(pathRe.firstMatch(pName)?.group(2) ?? '-1');
//       if (previousGoalId != parent.id) {
//         await push(context, replace: true, args: TaskController(parent));
//       }
//     }
//   }
// }
