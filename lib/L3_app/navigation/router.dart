// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../L1_domain/entities/task.dart';
import '../../L1_domain/entities_extensions/task_type.dart';
import '../../L2_data/services/platform.dart';
import '../presenters/task_tree.dart';
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
import 'route.dart';

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

  void _go(String location, {Object? extra = 'local'}) => go(location, extra: extra);

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
  void goTask(TaskDescriptor td, {bool direct = false}) {
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

  void goTaskFromTask(Task toTask, Task fromTask) {
    RouteMatchList rConfig = _currentConfig;
    // Выходим из исходной задачи
    // Поднимаемся на один уровень, если родители совпадают (проект или цель)
    // ...а также, когда задача открыта с главной
    if (toTask.parentId == fromTask.parentId || currentRoute.parent == mainRoute) {
      rConfig = rConfig.remove(rConfig.last);
    }
    // ...если родители не совпадают, поднимаемся до уровня общего проекта или корня
    else {
      final sameProject = toTask.project == fromTask.project;
      final prjType = TType.PROJECT.toLowerCase();
      while (rConfig.matches.length > 1 && (!sameProject || (rConfig.last.route as MTRoute).baseName != prjType)) {
        rConfig = rConfig.remove(rConfig.last);
      }
    }

    final pp = rConfig.pathParameters;
    pp.addAll({'taskId': '${toTask.id!}'});
    if (!pp.containsKey('wsId')) {
      pp.addAll({'wsId': '${toTask.wsId}'});
    }

    pushReplacementNamed('${rConfig.last.route.name}/task', pathParameters: pp, extra: 'local');
  }

  // 404 для задач
  String taskNotFoundLocation(MTRoute? parent) {
    RouteMatchList rConfig = _currentConfig;
    while (rConfig.matches.length > 1 && rConfig.last.route != parent) {
      rConfig = rConfig.remove(rConfig.last);
    }
    final parentLocation = rConfig.last.matchedLocation;
    return '${parentLocation == '/' ? '' : parentLocation}/${Task404Route.staticBaseName}';
  }

  void goTask404(MTRoute? parent) => _go(taskNotFoundLocation(parent));

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
  void popToTaskTypeOrMain(String type) {
    RouteMatchList rConfig = _currentConfig;
    type = type.toLowerCase();
    while (rConfig.matches.length > 1 && (rConfig.last.route as MTRoute).baseName != type) {
      rConfig = rConfig.remove(rConfig.last);
    }
    _go(rConfig.last.matchedLocation);
  }

  Future goInner(Uri uri) async {
    String location = uri.path;
    if (uri.hasQuery) {
      location += '/?${uri.query}';
    }
    _go(location);
  }
}
