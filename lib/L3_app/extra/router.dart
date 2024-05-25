// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_tree.dart';
import '../../L2_data/services/platform.dart';
import '../extra/route.dart';
import '../views/account/account_dialog.dart';
import '../views/auth/auth_view.dart';
import '../views/auth/invitation_token_controller.dart';
import '../views/auth/registration_token_controller.dart';
import '../views/main/main_view.dart';
import '../views/notification/notifications_dialog.dart';
import '../views/projects/projects_view.dart';
import '../views/quiz/abstract_task_quiz_controller.dart';
import '../views/source/sources_dialog.dart';
import '../views/task/widgets/empty_state/task_404_dialog.dart';
import '../views/workspace/ws_dialog.dart';
import '../views/workspace/ws_users_dialog.dart';

final _rootKey = GlobalKey<NavigatorState>();
BuildContext get globalContext => _rootKey.currentContext!;

final router = GoRouter(
    routes: [
      authRoute,
      registrationTokenRoute,
      invitationTokenRoute,
      mainRoute,
    ],
    navigatorKey: _rootKey,
    onException: (_, state, r) {
      if (kDebugMode) print('GoRouter onException -> $state');
      r.goMain();
    }
    // debugLogDiagnostics: true,
    );

extension MTPathParametersHelper on GoRouterState {
  int? pathParamInt(String param) => int.tryParse(pathParameters[param] ?? '');
}

extension MTRouterHelper on GoRouter {
  bool get isDeepLink => routerDelegate.currentConfiguration.extra == null;

  void _goNamed(
    String name, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) =>
      goNamed(
        name,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra ?? 'local',
      );

  // Главная и вход
  void goAuth() => _goNamed(authRoute.name);
  void goMain() => _goNamed(mainRoute.name);
  void goProjects() => _goNamed('${mainRoute.name}/${ProjectsRoute.staticBaseName}');
  void goAccount() => _goNamed('${mainRoute.name}/${AccountRoute.staticBaseName}');
  void goNotifications() => _goNamed('${mainRoute.name}/${NotificationsRoute.staticBaseName}');

  // WS
  String get _wsRName => '${mainRoute.name}/${WSRoute.staticBaseName}';
  void goWS(int wsId) => _goNamed(_wsRName, pathParameters: {'wsId': '$wsId'});
  void goWSSources(int wsId) => _goNamed('$_wsRName/${WSSourcesRoute.staticBaseName}', pathParameters: {'wsId': '$wsId'});
  void goWSUsers(int wsId) => _goNamed('$_wsRName/${WSUsersRoute.staticBaseName}', pathParameters: {'wsId': '$wsId'});

  // Задачи
  void goTaskView(Task task, {bool direct = false}) {
    RouteMatchList routeConfig = routerDelegate.currentConfiguration;
    final taskType = task.type.toLowerCase();
    final needPush = !direct && (!isWeb || task.isTask);
    final currentRoute = routeConfig.last.route as MTRoute;
    final currentName = needPush ? currentRoute.name : mainRoute.name;

    // не переходим по тому же маршруту (из задачи в задачу, из цели в цель, из проекта в проект)
    if (currentRoute.baseName != taskType) {
      final Map<String, String> pathParameters = needPush ? routeConfig.pathParameters : {};
      pathParameters.addAll({'wsId': '${task.wsId}', '${taskType}Id': '${task.id!}'});

      _goNamed('$currentName/$taskType', pathParameters: pathParameters);
    }
  }

  // 404 для задач
  void goTask404(MTRoute? parent) {
    RouteMatchList matches = routerDelegate.currentConfiguration;
    while (matches.matches.length > 1 && matches.last.route != parent) {
      matches = matches.remove(matches.last);
    }
    final parentLocation = matches.last.matchedLocation;

    go('${parentLocation == '/' ? '' : parentLocation}/${Task404Route.staticBaseName}');
  }

  // шаги квиза
  void goTaskQuizStep(String quizStepName, AbstractTaskQuizController qc, {bool push = false}) {
    RouteMatchList matches = routerDelegate.currentConfiguration;
    final stepIndex = qc.stepIndex;
    final needReplacePathPart = !push && stepIndex > 1;
    if (needReplacePathPart) matches = matches.remove(matches.last);

    go('${matches.last.matchedLocation}/$quizStepName', extra: qc);
  }

  // Выход из квиза
  void popToTaskType(String type) {
    RouteMatchList matches = routerDelegate.currentConfiguration;
    while (matches.matches.length > 1 && (matches.last.route as MTRoute).baseName != type) {
      matches = matches.remove(matches.last);
    }

    go(matches.last.matchedLocation);
  }
}
