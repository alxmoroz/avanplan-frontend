// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../L2_data/services/platform.dart';
import '../../main.dart';
import '../components/adaptive.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/dialog.dart';
import '../extra/services.dart';
import '../views/account/account_dialog.dart';
import '../views/auth/auth_view.dart';
import '../views/auth/invitation_token_controller.dart';
import '../views/auth/registration_token_controller.dart';
import '../views/loader/loader_screen.dart';
import '../views/main/main_view.dart';
import '../views/my_tasks/my_tasks_view.dart';
import '../views/notification/notification_list_dialog.dart';
import '../views/projects/projects_view.dart';
import '../views/source/source_list_dialog.dart';
import '../views/task/task_view.dart';
import '../views/task/widgets/create/create_multitask_quiz_view.dart';
import '../views/task/widgets/create/create_task_quiz_view.dart';
import '../views/task/widgets/feature_sets/feature_sets.dart';
import '../views/task/widgets/team/team_invitation_quiz_view.dart';
import '../views/workspace/ws_dialog.dart';
import '../views/workspace/ws_members_dialog.dart';

extension RouteSettingsExt on RouteSettings {
  Uri get uri => Uri.parse(name ?? '/');
}

final _routers = <MTRouter>[
  InvitationTokenRouter(),
  RegistrationTokenRouter(),

  //
  MainRouter(),
  // My Tasks
  MyTasksRouter(),
  // Projects
  ProjectsRouter(),

  // Projects - Create
  CreateProjectQuizRouter(),
  // Projects - Create - FeatureSets
  FeatureSetsQuizRouter(),
  // Projects - Create - Team
  TeamInvitationQuizRouter(),
  // Projects - Create - Goal
  CreateGoalQuizRouter(),
  // Projects - Create - Tasks
  CreateMultiTaskQuizRouter(),

  // Projects - Tasks / Goals
  TaskRouter(),

  // Settings - My Account
  AccountRouter(),
  // Settings - My Notifications
  NotificationsRouter(),
  // Settings - Workspaces
  WSRouter(),
  // Settings - Workspaces - Sources
  SourcesRouter(),
  // Settings - Workspaces - Members
  WSMembersRouter(),
];

abstract class MTRouter {
  String? previousName;
  // для title и settings
  RouteSettings? rs;

  String get title => '';
  RouteSettings? get settings => null;
  bool get isDialog => false;
  double get maxWidth => SCR_M_WIDTH;

  String path({Object? args}) => '/';
  RegExp get pathRe => RegExp('^${path()}\$');
  bool hasMatch(RouteSettings rsIn) {
    final match = pathRe.hasMatch(rsIn.uri.path);
    if (match) {
      rs = rsIn;
    }
    return match;
  }

  Widget? get page => null;

  Future push(BuildContext context, {MTRouter? removeUntil, bool replace = false, Object? args}) async {
    final n = Navigator.of(context);
    final p = path(args: args);
    if (removeUntil != null) {
      final stopPath = removeUntil.path(args: args);
      await n.pushNamedAndRemoveUntil(p, (r) => r.isFirst || r.settings.name == stopPath, arguments: args);
    } else if (replace) {
      await n.pushReplacementNamed(p, arguments: args);
    } else {
      await n.pushNamed(p, arguments: args);
    }
  }

  static MTRouter routerForType(Type type) => _routers.firstWhere((r) => r.runtimeType == type);
  static MTRouter? router(RouteSettings rs) => _routers.firstWhereOrNull((r) => r.hasMatch(rs));

  static Future navigate(Type type, BuildContext context, {Type? removeUntil, Object? args}) async =>
      routerForType(type).push(context, removeUntil: removeUntil != null ? routerForType(removeUntil) : null, args: args);

  static Widget _pageWidget(Widget child) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          authController.authorized ? child : const AuthView(),
          if (loader.loading) const LoaderScreen(),
        ],
      ),
    );
  }

  static Route? generateRoute(RouteSettings rs) {
    final r = router(rs);
    if (r != null) {
      final page = r.page;
      final settings = r.settings;
      final isDialog = r.isDialog;
      if (page != null) {
        return isDialog
            ? isBigScreen(globalContext)
                ? DialogRoute(
                    context: globalContext,
                    barrierColor: barrierColor,
                    settings: settings ?? rs,
                    builder: (_) => constrainedDialog(globalContext, _pageWidget(page), maxWidth: r.maxWidth),
                  )
                : ModalBottomSheetRoute(
                    useSafeArea: true,
                    constraints: dialogConstrains(globalContext, r.maxWidth),
                    modalBarrierColor: barrierColor,
                    isScrollControlled: true,
                    settings: settings ?? rs,
                    builder: (_) => _pageWidget(page),
                  )
            : isBigScreen(globalContext)
                ? PageRouteBuilder(
                    reverseTransitionDuration: const Duration(milliseconds: 150),
                    settings: settings ?? rs,
                    pageBuilder: (_, __, ___) => _pageWidget(page),
                  )
                : CupertinoPageRoute<dynamic>(
                    settings: settings ?? rs,
                    builder: (_) => _pageWidget(page),
                  );
      } else if (settings != null) {
        return generateRoute(settings);
      }
    }
    return null;
  }
}

Future setWebpageTitle(String title) async {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: '${loc.app_title}${title.isNotEmpty ? ' | $title' : ''}',
    primaryColor: mainColor.resolve(rootKey.currentContext!).value,
  ));
}

class MTRouteObserver extends NavigatorObserver {
  void _setTitle(MTRouter r) {
    // Только для веба
    if (isWeb) {
      setWebpageTitle(r.title);
    }
  }

  void _setTitleWithRS(RouteSettings? rs) {
    if (rs != null) {
      final r = MTRouter.router(rs);
      if (r != null) {
        _setTitle(r);
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    final rs = route.settings;
    final r = MTRouter.router(rs);
    if (r != null) {
      _setTitle(r);
      r.previousName = previousRoute?.settings.name;
    }
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _setTitleWithRS(previousRoute?.settings);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    final newRS = newRoute?.settings;
    if (newRS != null) {
      final r = MTRouter.router(newRS);
      if (r != null) {
        _setTitle(r);
        r.previousName = oldRoute?.settings.name;
      }
    }

    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    print('pop ${route.settings.name} -> ${previousRoute?.settings.name}');
    _setTitleWithRS(previousRoute?.settings);
    super.didPop(route, previousRoute);
  }
}

void popTop() => Navigator.of(rootKey.currentContext!).popUntil((r) => r.isFirst);
