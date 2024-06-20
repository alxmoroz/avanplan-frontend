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
import '../views/main/onboarding/onboarding_view.dart';
import '../views/notification/notifications_dialog.dart';
import '../views/projects/projects_view.dart';
import '../views/quiz/abstract_task_quiz_controller.dart';
import '../views/source/sources_dialog.dart';
import '../views/task/widgets/empty_state/task_404_dialog.dart';
import '../views/workspace/ws_route.dart';
import '../views/workspace/ws_users_dialog.dart';

final _rootKey = GlobalKey<NavigatorState>();
BuildContext get globalContext => _rootKey.currentContext!;

final router = GoRouter(
    // debugLogDiagnostics: true,
    routes: [
      authRoute,
      registrationTokenRoute,
      invitationTokenRoute,
      mainRoute,
      onboardingRoute,
    ],
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
  MTRoute get _currentRoute => _currentConfig.last.route as MTRoute;

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
  void goAccount() => _goNamed('${mainRoute.name}/${AccountRoute.staticBaseName}');
  void goNotifications() => _goNamed('${mainRoute.name}/${NotificationsRoute.staticBaseName}');

  // WS
  String get _wsRName => '${mainRoute.name}/${WSRoute.staticBaseName}';
  void goWS(int wsId) => _goNamed(_wsRName, pathParameters: {'wsId': '$wsId'});
  void goWSSources(int wsId) => _goNamed('$_wsRName/${WSSourcesRoute.staticBaseName}', pathParameters: {'wsId': '$wsId'});
  void goWSUsers(int wsId) => _goNamed('$_wsRName/${WSUsersRoute.staticBaseName}', pathParameters: {'wsId': '$wsId'});

  // Задачи
  void goTaskView(Task task, {bool direct = false}) {
    final tt = task.type.toLowerCase();
    final currentPP = _currentConfig.pathParameters;
    final ttIdKey = '${tt}Id';

    if (currentPP['wsId'] != '${task.wsId}' || (!currentPP.containsKey(ttIdKey) || currentPP[ttIdKey] != '${task.id!}')) {
      final needPush = !direct && (!isWeb || task.isTask);
      final Map<String, String> pp = needPush ? currentPP : {};
      pp.addAll({'wsId': '${task.wsId}', ttIdKey: '${task.id!}'});
      final currentName = needPush ? _currentRoute.name : mainRoute.name;
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
  Future pushOnboarding() async => await pushNamed(onboardingRoute.name, extra: 'local');

  // шаги квиза создания цели / проекта
  Future pushTaskQuizStep(
    String stepName,
    AbstractTaskQuizController qc, {
    bool needAppendPath = false,
    Map<String, String> pathParameters = const <String, String>{},
  }) async {
    final stepIndex = qc.stepIndex;
    needAppendPath = needAppendPath || stepIndex < 2;
    final parentName = needAppendPath ? _currentRoute.name : _currentRoute.parent!.name;
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
