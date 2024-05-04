// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../components/adaptive.dart';
import '../../components/constants.dart';
import '../../extra/route.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/task_type.dart';
import 'task_view.dart';
import 'widgets/create/create_subtasks_quiz_view.dart';
import 'widgets/create/create_task_quiz_view.dart';
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
  String title(GoRouterState state) => task(state).viewTitle;

  @override
  bool isDialog(BuildContext context) => isBigScreen(context) && baseName == TType.TASK.toLowerCase();

  Task task(GoRouterState state) {
    final wsId = state.pathParamInt('wsId')!;
    final taskId = state.pathParamInt('${baseName}Id')!;

    final existingT = tasksMainController.task(wsId, taskId);
    return existingT ??
        Task(
          wsId: wsId,
          id: taskId,
          type: baseName.toUpperCase(),
          title: '',
          startDate: null,
          closed: false,
          parentId: null,
          notes: [],
          attachments: [],
          members: [],
          projectStatuses: [],
          projectFeatureSets: [],
        );
  }

  @override
  GoRouterWidgetBuilder? get builder => (context, state) {
        return Observer(
          builder: (_) => loader.loading
              ? Container()
              : Builder(
                  builder: (_) {
                    final t = task(state);
                    t.immutable = router.isDeepLink && state.matchedLocation == state.uri.path;
                    return t.creating && (t.isProject || t.isGoal) ? CreateTaskQuizView(t) : TaskView(t);
                  },
                ),
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
