// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../L1_domain/entities/task.dart';
import '../../L2_data/services/platform.dart';
import '../components/adaptive.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/dialog.dart';
import '../extra/services.dart';
import '../views/account/account_dialog.dart';
import '../views/auth/auth_view.dart';
import '../views/auth/registration_token_controller.dart';
import '../views/loader/loader_screen.dart';
import '../views/main/main_view.dart';
import '../views/notification/notifications_dialog.dart';
import '../views/projects/projects_view.dart';
import '../views/source/sources_dialog.dart';
import '../views/task/controllers/task_controller.dart';
import '../views/task/task_route.dart';
import '../views/task/widgets/create/create_subtasks_quiz_view.dart';
import '../views/task/widgets/feature_sets/feature_sets.dart';
import '../views/task/widgets/team/team_quiz_view.dart';
import '../views/workspace/ws_dialog.dart';
import '../views/workspace/ws_users_dialog.dart';

void _setWebpageTitle(BuildContext context, String title) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: '${loc.app_title}${title.isNotEmpty ? ' | $title' : ''}',
    primaryColor: mainColor.resolve(context).value,
  ));
}

class MTRoute extends GoRoute {
  MTRoute({
    required super.path,
    required super.name,
    super.routes,
    super.redirect,
    GoRouterWidgetBuilder? builder,
  }) : super(builder: builder ?? (_, __) => Container());

  double get dialogMaxWidth => SCR_S_WIDTH;

  bool isDialog(BuildContext context) => false;

  String? title(GoRouterState state) => null;

  @override
  GoRouterPageBuilder? get pageBuilder => (BuildContext context, GoRouterState state) {
        if (isWeb) _setWebpageTitle(context, title(state) ?? '');

        final child = Observer(
          builder: (_) => Stack(
            alignment: Alignment.center,
            children: [
              builder!(context, state),
              if (loader.loading) const LoaderScreen(),
            ],
          ),
        );

        return isDialog(context)
            ? MTDialogPage(
                name: state.name,
                arguments: state.extra,
                maxWidth: dialogMaxWidth,
                child: child,
              )
            : isBigScreen(context)
                //TODO: NoTransitionPage?
                ? MaterialPage(
                    name: state.name,
                    arguments: state.extra,
                    child: child,
                  )
                : CupertinoPage(
                    name: state.name,
                    arguments: state.extra,
                    child: child,
                  );
      };
}

extension MTPathParametersHelper on GoRouterState {
  int? intPathParam(String param) => int.tryParse(pathParameters[param] ?? '');
}

extension MTRouterHelper on BuildContext {
  // Главная и вход
  void goAuth() => goNamed(authRoute.name!);
  void goMain() => goNamed(mainRoute.name!);
  void goProjects() => goNamed(projectsRoute.name!);
  void goAccount() => goNamed(accountRoute.name!);
  void goNotifications() => goNamed(notificationsRoute.name!);

  // WS
  void goWS(int wsId) => goNamed(wsRoute.name!, pathParameters: {'wsId': '$wsId'});
  void goWSSources(int wsId) => goNamed(wsSourcesRoute.name!, pathParameters: {'wsId': '$wsId'});
  void goWSUsers(int wsId) => goNamed(wsUsersRoute.name!, pathParameters: {'wsId': '$wsId'});

  // Задачи
  void _goTask(int wsId, int taskId, {String rName = 'task', String? subRouteName, Object? extra}) => goNamed(
        subRouteName ?? rName,
        pathParameters: {'wsId': '$wsId', '${rName}Id': '$taskId'},
        extra: extra,
      );

  void goLocalTask(Task task, {String? subRouteName, Object? extra}) => _goTask(
        task.wsId,
        task.id!,
        rName: TaskRoute.rName(task),
        subRouteName: subRouteName,
        extra: extra,
      );

  void goFeatureSetsQuiz(TaskController tc) => goLocalTask(
        tc.taskDescriptor,
        subRouteName: featureSetsQuizRoute.name!,
        extra: tc,
      );

  void goTeamQuiz(TaskController tc) => goLocalTask(
        tc.taskDescriptor,
        subRouteName: teamQuizRoute.name!,
        extra: tc,
      );

  void goSubtasksQuiz(TaskController tc) => goLocalTask(
        tc.taskDescriptor,
        subRouteName: createSubtasksQuizRoutes[TaskRoute.rName(tc.taskDescriptor)]!.name!,
        extra: tc,
      );
}

final rootKey = GlobalKey<NavigatorState>();
BuildContext get globalContext => rootKey.currentContext!;

final goRouter = GoRouter(
  routes: [
    authRoute,
    registrationTokenRoute,
    mainRoute,
  ],
  // observers: [MTRouteObserver()],
  navigatorKey: rootKey,
);

// Future push(BuildContext context, {MTRouter? removeUntil, bool replace = false, Object? args}) async {
//   final n = Navigator.of(context);
//   final p = path(args: args);
//   if (removeUntil != null) {
//     final stopPath = removeUntil.path(args: args);
//     await n.pushNamedAndRemoveUntil(p, (r) => r.isFirst || r.settings.name == stopPath, arguments: args);
//   } else if (replace) {
//     await n.pushReplacementNamed(p, arguments: args);
//   } else {
//     await n.pushNamed(p, arguments: args);
//   }
// }

// static Future navigate(Type type, BuildContext context, {Type? removeUntil, Object? args}) async =>
//     routerForType(type).push(context, removeUntil: removeUntil != null ? routerForType(removeUntil) : null, args: args);
// }

// class MTRouteObserver extends NavigatorObserver {
//   // void _setRouteChanges(Route? r, String? prevName) {
//   //   final rs = r?.settings;
//   //   if (rs != null) {
//   //     final r = MTRouter.router(rs);
//   //     if (r != null) {
//   //       _setTitle(r);
//   // r.prevName = prevName;
//   // }
//   // }
//   // }
//
//   @override
//   void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     // _setRouteChanges(route, previousRoute?.settings.name);
//     super.didPush(route, previousRoute);
//   }
//
//   @override
//   void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     // _setRouteChanges(route, route.settings.name);
//     super.didRemove(route, previousRoute);
//   }
//
//   @override
//   void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
//     // _setRouteChanges(newRoute, newRoute?.settings.name);
//     super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
//   }
//
//   @override
//   void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
//     // _setRouteChanges(route, route.settings.name);
//     super.didPop(route, previousRoute);
//   }
// }
