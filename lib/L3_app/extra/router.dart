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
import '../views/source/sources_dialog.dart';
import '../views/task/controllers/task_controller.dart';
import '../views/task/widgets/create/create_subtasks_quiz_view.dart';
import '../views/task/widgets/empty_state/task_404_dialog.dart';
import '../views/task/widgets/feature_sets/feature_sets.dart';
import '../views/task/widgets/team/team_quiz_view.dart';
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

  MTRoute get _currentRoute => routerDelegate.currentConfiguration.last.route as MTRoute;

  bool get isDeepLink => routerDelegate.currentConfiguration.extra == null;

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
  void goTaskView(Task task, {String? subRouteName, Object? extra}) {
    final taskRouteName = task.type.toLowerCase();
    subRouteName ??= '';
    if (subRouteName.isNotEmpty) subRouteName = '/$subRouteName';

    final needPush = !isWeb || task.isTask;
    final currentName = needPush ? _currentRoute.name : mainRoute.name;

    if (_currentRoute.baseName != taskRouteName) {
      final Map<String, String> pathParameters = needPush ? routerDelegate.currentConfiguration.pathParameters : {};
      pathParameters.addAll({'wsId': '${task.wsId}', '${taskRouteName}Id': '${task.id!}'});

      _goNamed(
        '$currentName/$taskRouteName$subRouteName',
        pathParameters: pathParameters,
        extra: extra,
      );
    }
  }

  // 404 для задач
  void goTask404(MTRoute? parent) {
    RouteMatchList matches = routerDelegate.currentConfiguration;
    while (matches.matches.length > 1 && matches.last.route != parent) {
      matches = matches.remove(matches.last);
    }
    go('${matches.last.matchedLocation}/${Task404Route.staticBaseName}');
  }

  void goFeatureSetsQuiz(TaskController tc) => goTaskView(
        tc.taskDescriptor,
        subRouteName: FeatureSetsQuizRoute.staticBaseName,
        extra: tc,
      );

  void goTeamQuiz(TaskController tc) => goTaskView(
        tc.taskDescriptor,
        subRouteName: TeamQuizRoute.staticBaseName,
        extra: tc,
      );

  void goSubtasksQuiz(TaskController tc) => goTaskView(
        tc.taskDescriptor,
        subRouteName: CreateSubtasksQuizRoute.staticBaseName,
        extra: tc,
      );
}
