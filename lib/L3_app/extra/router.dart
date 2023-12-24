// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../components/adaptive.dart';
import '../components/colors.dart';
import '../components/constants.dart';
import '../components/dialog.dart';
import '../extra/services.dart';
import '../views/account/account_view.dart';
import '../views/auth/auth_view.dart';
import '../views/auth/invitation_token_controller.dart';
import '../views/auth/registration_token_controller.dart';
import '../views/loader/loader_screen.dart';
import '../views/main/main_view.dart';
import '../views/my_tasks/my_tasks_view.dart';
import '../views/notification/notification_list_view.dart';
import '../views/projects/projects_view.dart';
import '../views/settings/settings_view.dart';
import '../views/source/source_list_view.dart';
import '../views/task/task_view.dart';
import '../views/task/widgets/create/create_multitask_quiz_view.dart';
import '../views/task/widgets/create/create_task_quiz_view.dart';
import '../views/task/widgets/feature_sets/feature_sets.dart';
import '../views/task/widgets/project_statuses/project_statuses.dart';
import '../views/task/widgets/team/team_invitation_quiz_view.dart';
import '../views/user/user_list_view.dart';
import '../views/workspace/workspace_view.dart';

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
  // Projects - Create - Statuses
  ProjectStatusesQuizRouter(),
  // Projects - Create - Team
  TeamInvitationQuizRouter(),
  // Projects - Create - Goal
  CreateGoalQuizRouter(),
  // Projects - Create - Tasks
  CreateMultiTaskQuizRouter(),

  // Projects - Tasks / Goals
  TaskRouter(),

  // Settings
  SettingsRouter(),
  // Settings - My Account
  AccountRouter(),
  // Settings - My Notifications
  NotificationsRouter(),
  // Settings - Workspaces
  WorkspaceRouter(),
  // Settings - Workspaces - Sources
  SourcesRouter(),
  // Settings - Workspaces - Users
  UsersRouter(),
];

abstract class MTRouter {
  String? previousName;
  // для title и settings
  RouteSettings? rs;

  String get title => '';
  RouteSettings? get settings => null;
  bool get isDialog => false;
  double get maxWidth => SCR_M_WIDTH;

  String get path => '/';
  RegExp get pathRe => RegExp('^$path\$');
  bool hasMatch(RouteSettings _rs) {
    final match = pathRe.hasMatch(_rs.uri.path);
    if (match) {
      rs = _rs;
    }
    return match;
  }

  Widget? get page => null;
  Future pushNamed(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed(path, arguments: args);

  static MTRouter routerForType(Type type) => _routers.firstWhere((r) => r.runtimeType == type);
  static MTRouter? router(RouteSettings rs) => _routers.firstWhereOrNull((r) => r.hasMatch(rs));
  static Future navigate(Type type, BuildContext context, {Object? args}) async => routerForType(type).pushNamed(context, args: args);

  static Widget _pageWidget(Widget child, bool isDialog, double maxWidth) {
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.center,
        children: [
          authController.authorized ? (isDialog ? MTAdaptiveDialog(child, maxWidth: maxWidth) : child) : AuthView(),
          if (loader.loading) LoaderScreen(),
        ],
      ),
    );
  }

  static PageRoute? generateRoute(RouteSettings rs) {
    final r = router(rs);
    if (r != null) {
      final page = r.page;
      final settings = r.settings;
      final isDialog = r.isDialog;
      if (page != null) {
        return showSideMenu
            ? PageRouteBuilder(
                pageBuilder: (_, __, ___) => _pageWidget(page, isDialog, r.maxWidth),
                reverseTransitionDuration: const Duration(milliseconds: 150),
                settings: settings ?? rs,
                fullscreenDialog: isDialog,
                barrierDismissible: isDialog,
                opaque: false,
                barrierColor: barrierColor,
              )
            : CupertinoPageRoute<dynamic>(
                builder: (_) => _pageWidget(page, isDialog, r.maxWidth),
                fullscreenDialog: isDialog,
                barrierDismissible: isDialog,
                settings: settings ?? rs,
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
    if (kIsWeb) {
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
    _setTitleWithRS(previousRoute?.settings);
    super.didPop(route, previousRoute);
  }
}

void popTop() => Navigator.of(rootKey.currentContext!).popUntil((r) => r.navigator?.canPop() == false);
