// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../main.dart';
import '../components/colors.dart';
import '../extra/services.dart';
import '../views/account/account_view.dart';
import '../views/auth/auth_view.dart';
import '../views/auth/invitation_token_controller.dart';
import '../views/auth/registration_token_controller.dart';
import '../views/loader/loader_screen.dart';
import '../views/main/main_view.dart';
import '../views/my_projects/my_projects_view.dart';
import '../views/my_tasks/my_tasks_view.dart';
import '../views/notification/notification_list_view.dart';
import '../views/settings/settings_view.dart';
import '../views/source/source_list_view.dart';
import '../views/user/user_list_view.dart';
import '../views/workspace/workspace_view.dart';

extension RouteSettingsExt on RouteSettings {
  Uri get uri => Uri.parse(name ?? '/');
}

abstract class MTRouter {
  Uri? uri;

  String get path => '/';
  RegExp get pathRe => RegExp('^$path\$');
  bool hasMatch(Uri uri) => pathRe.hasMatch(uri.path);

  Widget? get page => null;
  String get title => '';
  RouteSettings? settings(RouteSettings rs) => null;
  Future navigate(BuildContext context) async => await Navigator.of(context).pushNamed(path);

  static final routers = <MTRouter>[
    InvitationTokenRouter(),
    RegistrationTokenRouter(),
    // Main
    MainViewRouter(),
    MyTasksViewViewRouter(),
    // Main - Projects
    MyProjectsViewRouter(),
    // Main - Projects - Task
    // TaskViewRouter(),

    // Settings
    SettingsViewRouter(),
    AccountViewRouter(),
    NotificationListViewRouter(),
    // Settings - Workspaces
    WorkspaceViewRouter(),
    // Settings - Workspaces - Sources
    SourceListViewRouter(),
    // Settings - Workspaces - Users
    UserListViewRouter(),
  ];

  static CupertinoPageRoute? generateRoute(RouteSettings rs) {
    final uri = rs.uri;
    final router = routers.firstWhereOrNull((r) => r.hasMatch(uri))?..uri = uri;
    if (router != null) {
      final page = router.page;
      final settings = router.settings(rs);
      if (page != null) {
        return CupertinoPageRoute<dynamic>(
          builder: (_) => Observer(
            builder: (_) => Stack(
              children: [
                authController.authorized ? page : AuthView(),
                if (loader.loading) LoaderScreen(),
              ],
            ),
          ),
          settings: settings ?? rs,
        );
      } else if (settings != null) {
        return generateRoute(settings);
      }
    }
    return null;
  }

  static String? generateTitle(Uri uri) => (routers.firstWhereOrNull((r) => r.hasMatch(uri))?..uri = uri)?.title;

  //   } else if ([CreateTaskQuizView.routeNameProject, CreateTaskQuizView.routeNameGoal].contains(path) && hasArgs) {
  //     p = CreateTaskQuizView(rs.arguments as CreateTaskQuizArgs);
  //   } else if (path == CreateMultiTaskQuizView.routeName && hasArgs) {
  //     p = CreateMultiTaskQuizView(rs.arguments as CreateMultiTaskQuizArgs);
  //   } else if (path == MemberView.routeName && hasArgs) {
  //     p = MemberView(rs.arguments as MemberViewArgs);
  //   } else if (path == FeatureSetsQuizView.routeName && hasArgs) {
  //     p = FeatureSetsQuizView(rs.arguments as FSQuizArgs);
  //   } else if (path == ProjectStatusesQuizView.routeName && hasArgs) {
  //     p = ProjectStatusesQuizView(rs.arguments as PSQuizArgs);
  //   } else if (path == TeamInvitationQuizView.routeName && hasArgs) {
  //     p = TeamInvitationQuizView(rs.arguments as TIQuizArgs);
  //   }
}

void _setTitle(RouteSettings? rs) {
  if (rs == null) {
    return;
  }

  final title = MTRouter.generateTitle(rs.uri) ?? '';

  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: '${loc.app_title}${title.isNotEmpty ? ' | $title' : ''}',
    primaryColor: mainColor.resolve(rootKey.currentContext!).value,
  ));
}

class MTRouteObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _setTitle(route.settings);
    super.didPush(route, previousRoute);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _setTitle(previousRoute?.settings);
    super.didRemove(route, previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    _setTitle(newRoute?.settings);
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    _setTitle(previousRoute?.settings);
    super.didPop(route, previousRoute);
  }
}
