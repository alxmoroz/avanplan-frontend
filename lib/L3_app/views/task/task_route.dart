// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../components/adaptive.dart';
import '../../components/constants.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/task_type.dart';
import 'task_view.dart';
import 'widgets/create/create_subtasks_quiz_view.dart';
import 'widgets/create/create_task_quiz_view.dart';
import 'widgets/empty_state/not_found_dialog.dart';
import 'widgets/feature_sets/feature_sets.dart';
import 'widgets/team/team_quiz_view.dart';

class TaskRoute extends MTRoute {
  TaskRoute({required super.path, required super.name, super.routes, super.redirect});

  TaskRoute.inboxRoute() : super(path: 'ws/:wsId/inbox/:inboxId', name: 'inbox');
  TaskRoute.projectRoute()
      : super(
          path: 'ws/:wsId/projects/:projectId',
          name: 'project',
          routes: [featureSetsQuizRoute, teamQuizRoute, createSubtasksProjectQuizRoute],
        );
  TaskRoute.goalRoute()
      : super(
          path: 'ws/:wsId/goals/:goalId',
          name: 'goal',
          routes: [createSubtasksGoalQuizRoute],
        );
  TaskRoute.backlogRoute() : super(path: 'ws/:wsId/backlogs/:backlogId', name: 'backlog');
  TaskRoute.taskRoute() : super(path: 'ws/:wsId/tasks/:taskId', name: 'task');

  static String rName(Task t) => t.isProject
      ? 'project'
      : t.isInbox
          ? 'inbox'
          : t.isGoal
              ? 'goal'
              : t.isBacklog
                  ? 'backlog'
                  : 'task';

  @override
  double get dialogMaxWidth => SCR_L_WIDTH;

  @override
  String? title(GoRouterState state) {
    final t = task(state);
    return t != null ? t.viewTitle : loc.error_404_task_title;
  }

  bool get _isTaskRoute => name == 'task';

  @override
  bool isDialog(BuildContext context) => isBigScreen(context) && _isTaskRoute;

  Task? task(GoRouterState state) {
    final wsId = state.intPathParam('wsId');
    final taskId = state.intPathParam('${name}Id');
    return wsId != null && taskId != null ? tasksMainController.task(wsId, taskId) : null;
  }

  @override
  GoRouterRedirect? get redirect => (context, state) => task(state) != null ? null : context.namedLocation(taskNotFoundRoute.name!);

  @override
  GoRouterWidgetBuilder? get builder => (context, state) {
        print('TaskRoute builder ${state.name}');

        final t = task(state)!;
        final isNew = state.extra != null;
        if (isNew && (t.isProject || t.isGoal)) {
          return CreateTaskQuizView(t);
        }
        return TaskView(t, isNew: isNew);
      };
}

final inboxRoute = TaskRoute.inboxRoute();
final projectRoute = TaskRoute.projectRoute();
final goalRoute = TaskRoute.goalRoute();
final backlogRoute = TaskRoute.backlogRoute();
final taskRoute = TaskRoute.taskRoute();

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
