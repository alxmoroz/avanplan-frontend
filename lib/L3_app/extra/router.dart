// Copyright (c) 2023. Alexandr Moroz

import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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
import '../views/task/widgets/team/member_view.dart';
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

  // Projects - Members
  MemberRouter(),
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

  static MTRouter? router(RouteSettings rs) => _routers.firstWhereOrNull((r) => r.hasMatch(rs));

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
}

Future setWebpageTitle(String title) async {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: '${loc.app_title}${title.isNotEmpty ? ' | $title' : ''}',
    primaryColor: mainColor.resolve(rootKey.currentContext!).value,
  ));
}

void _setTitle(RouteSettings? rs) {
  // Только для веба
  if (kIsWeb && rs != null) {
    setWebpageTitle(MTRouter.router(rs)?.title ?? '');
  }
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
