// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../../L2_data/services/platform.dart';
import '../extra/route.dart';
import '../views/auth/auth_view.dart';
import '../views/main/main_view.dart';
import '../views/my_account/my_account_dialog.dart';
import '../views/notification/notifications_dialog.dart';
import '../views/onboarding/onboarding_view.dart';
import '../views/projects/projects_view.dart';
import '../views/quiz/abstract_task_quiz_controller.dart';
import '../views/source/sources_dialog.dart';
import '../views/task/widgets/empty_state/task_404_dialog.dart';
import '../views/workspace/ws_route.dart';
import '../views/workspace/ws_users_dialog.dart';
import 'deep_links_routes.dart';

final _rootKey = GlobalKey<NavigatorState>();
BuildContext get globalContext => _rootKey.currentContext!;

final router = GoRouter(
    // debugLogDiagnostics: true,
    routes: [
      authRoute,
      registrationTokenRoute,
      invitationTokenRoute,
      yandexOauthWebRedirectRoute,
      mainRoute,
      onboardingRoute,
    ],
    initialLocation: '/',
    initialExtra: 'local',
    navigatorKey: _rootKey,
    onException: (_, state, r) {
      if (kDebugMode) print('GoRouter onException -> $state');
      r.goMain();
    });

extension MTPathParametersHelper on GoRouterState {
  int? pathParamInt(String param) => int.tryParse(pathParameters[param] ?? '');
}

extension MTRouterHelper on GoRouter {
  RouteMatchList get _currentConfig => routerDelegate.currentConfiguration;
  MTRoute get currentRoute => _currentConfig.last.route as MTRoute;

  bool get isDeepLink => _currentConfig.extra == null;

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
  void goAccount() => _goNamed('${mainRoute.name}/${MyAccountRoute.staticBaseName}');
  void goNotifications() => _goNamed('${mainRoute.name}/${NotificationsRoute.staticBaseName}');

  // WS
  String get _wsRName => '${mainRoute.name}/${WSRoute.staticBaseName}';
  void goWS(int wsId) => _goNamed(_wsRName, pathParameters: {'wsId': '$wsId'});
  void goWSSources(int wsId) => _goNamed('$_wsRName/${WSSourcesRoute.staticBaseName}', pathParameters: {'wsId': '$wsId'});
  void goWSUsers(int wsId) => _goNamed('$_wsRName/${WSUsersRoute.staticBaseName}', pathParameters: {'wsId': '$wsId'});

  // Задачи
  void goTaskView(TaskDescriptor td, {bool direct = false}) {
    final tt = td.type.toLowerCase();
    final currentPP = _currentConfig.pathParameters;
    final ttIdKey = '${tt}Id';

    if (currentPP['wsId'] != '${td.wsId}' || (!currentPP.containsKey(ttIdKey) || currentPP[ttIdKey] != '${td.id!}')) {
      final needPush = !direct && (!isWeb || td.isTask);
      final Map<String, String> pp = needPush ? currentPP : {};
      pp.addAll({'wsId': '${td.wsId}', ttIdKey: '${td.id!}'});
      final currentName = needPush ? currentRoute.name : mainRoute.name;
      _goNamed('$currentName/$tt', pathParameters: pp);
    }
  }

  // 404 для задач
  void goTask404(MTRoute? parent) {
    RouteMatchList rConfig = _currentConfig;
    while (rConfig.matches.length > 1 && rConfig.last.route != parent) {
      rConfig = rConfig.remove(rConfig.last);
    }
    final parentLocation = rConfig.last.matchedLocation;

    go('${parentLocation == '/' ? '' : parentLocation}/${Task404Route.staticBaseName}');
  }

  // главный онбординг
  Future pushOnboarding({TaskDescriptor? hostProject}) async => await pushNamed(onboardingRoute.name, extra: hostProject ?? 'local');

  // шаги квиза создания цели / проекта
  Future pushTaskQuizStep(
    String stepName,
    AbstractTaskQuizController qc, {
    bool needAppendPath = false,
    Map<String, String> pathParameters = const <String, String>{},
  }) async {
    final stepIndex = qc.stepIndex;
    needAppendPath = needAppendPath || stepIndex < 2;
    final parentName = needAppendPath ? currentRoute.name : currentRoute.parent!.name;
    final pp = _currentConfig.pathParameters;
    pp.addAll(pathParameters);

    await pushNamed('$parentName/$stepName', pathParameters: pp, extra: qc);
  }

  // Выход из квиза создания цели или проекта
  void popToTaskType(String type) {
    RouteMatchList rConfig = _currentConfig;
    while (rConfig.matches.length > 1 && (rConfig.last.route as MTRoute).baseName != type) {
      rConfig = rConfig.remove(rConfig.last);
    }

    go(rConfig.last.matchedLocation);
  }
}
