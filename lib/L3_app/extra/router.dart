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
import '../views/task/task_view.dart';
import '../views/task/widgets/create/create_task_quiz_view.dart';
import '../views/task/widgets/team/member_view.dart';
import '../views/user/user_list_view.dart';
import '../views/workspace/workspace_view.dart';

extension RouteSettingsExt on RouteSettings {
  Uri get uri => Uri.parse(name ?? '/');
}

abstract class MTRouter {
  // для title и settings
  RouteSettings? rs;
  String get title => '';
  RouteSettings? get settings => null;

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
  Future navigate(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed(path, arguments: args);

  static final routers = <MTRouter>[
    InvitationTokenRouter(),
    RegistrationTokenRouter(),
    //
    MainViewRouter(),
    // My Tasks
    MyTasksViewViewRouter(),
    // Projects
    MyProjectsViewRouter(),
    // Projects - Create
    CreateProjectQuizViewRouter(),
    // Projects - Create Goal
    CreateGoalQuizViewRouter(),

    // Projects - Tasks
    TaskViewRouter(),
    // Projects - Tasks - Members
    MemberViewRouter(),

    // Settings
    SettingsViewRouter(),
    // Settings - My Account
    AccountViewRouter(),
    // Settings - My Notifications
    NotificationListViewRouter(),
    // Settings - Workspaces
    WorkspaceViewRouter(),
    // Settings - Workspaces - Sources
    SourceListViewRouter(),
    // Settings - Workspaces - Users
    UserListViewRouter(),
  ];

  static MTRouter? router(RouteSettings rs) => routers.firstWhereOrNull((r) => r.hasMatch(rs));

  static CupertinoPageRoute? generateRoute(RouteSettings rs) {
    final r = router(rs);
    if (r != null) {
      final page = r.page;
      final settings = r.settings;
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

  //   } else if (path == CreateMultiTaskQuizView.routeName && hasArgs) {
  //     p = CreateMultiTaskQuizView(rs.arguments as CreateMultiTaskQuizArgs);
  //   } else if (path == FeatureSetsQuizView.routeName && hasArgs) {
  //     p = FeatureSetsQuizView(rs.arguments as FSQuizArgs);
  //   } else if (path == ProjectStatusesQuizView.routeName && hasArgs) {
  //     p = ProjectStatusesQuizView(rs.arguments as PSQuizArgs);
  //   } else if (path == TeamInvitationQuizView.routeName && hasArgs) {
  //     p = TeamInvitationQuizView(rs.arguments as TIQuizArgs);
  //   }
}

Future setWebpageTitle(String title) async {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: '${loc.app_title}${title.isNotEmpty ? ' | $title' : ''}',
    primaryColor: mainColor.resolve(rootKey.currentContext!).value,
  ));
}

void _setTitle(RouteSettings? rs) {
  if (rs == null) {
    return;
  }

  setWebpageTitle(MTRouter.router(rs)?.title ?? '');
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
