// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../L1_domain/entities/user.dart';
import '../../main.dart';
import '../components/colors.dart';
import '../extra/services.dart';
import '../views/account/account_view.dart';
import '../views/my_projects/my_projects_view.dart';
import '../views/my_tasks/my_tasks_view.dart';
import '../views/notification/notification_list_view.dart';
import '../views/settings/settings_view.dart';
import '../views/source/source_list_view.dart';
import '../views/task/controllers/task_controller.dart';
import '../views/task/task_view.dart';
import '../views/task/widgets/create/create_multitask_quiz_view.dart';
import '../views/task/widgets/create/create_task_quiz_view.dart';
import '../views/task/widgets/feature_sets/feature_sets.dart';
import '../views/task/widgets/team/member_view.dart';
import '../views/task/widgets/team/team_invitation_view.dart';
import '../views/user/user_list_view.dart';
import '../views/user/user_view.dart';
import '../views/workspace/workspace_view.dart';

void setPageTitle(String title) {
  SystemChrome.setApplicationSwitcherDescription(ApplicationSwitcherDescription(
    label: '${loc.app_title}${title.isNotEmpty ? ' - $title' : ''}',
    primaryColor: mainColor.resolve(rootKey.currentContext!).value,
  ));
}

CupertinoPageRoute? cupertinoPageRoute(RouteSettings rs) {
  if (rs.name == null) {
    return null;
  }

  Widget? p;
  if (rs.name == NotificationListView.routeName) {
    p = NotificationListView();
  } else if (rs.name == MyProjectsView.routeName) {
    p = MyProjectsView();
  } else if (rs.name == MyTasksView.routeName) {
    p = MyTasksView();
  } else if (rs.name == SettingsView.routeName) {
    p = SettingsView();
  } else if (rs.name == AccountView.routeName) {
    p = AccountView();
  } else if (rs.name == UserListView.routeName) {
    p = UserListView(rs.arguments as int);
  } else if (rs.name == WorkspaceView.routeName) {
    p = WorkspaceView(rs.arguments as int);
  } else if (rs.name == SourceListView.routeName) {
    p = SourceListView(rs.arguments as int);
  } else if (rs.name == TaskView.routeName) {
    final tc = rs.arguments as TaskController;
    p = TaskView(tc);
    rs = RouteSettings(name: '${rs.name}_${tc.task.id}', arguments: rs.arguments);
  } else if ([CreateTaskQuizView.routeNameProject, CreateTaskQuizView.routeNameGoal].contains(rs.name)) {
    final args = rs.arguments as CreateTaskQuizArgs;
    p = CreateTaskQuizView(args);
  } else if (rs.name == CreateMultiTaskQuizView.routeName) {
    final args = rs.arguments as CreateMultiTaskQuizArgs;
    p = CreateMultiTaskQuizView(args);
  } else if (rs.name == MemberView.routeName) {
    final args = rs.arguments as MemberViewArgs;
    p = MemberView(args);
  } else if (rs.name == UserView.routeName) {
    final user = rs.arguments as User;
    p = UserView(user);
  } else if (rs.name == FeatureSetsQuizView.routeName) {
    final args = rs.arguments as FSQuizArgs;
    p = FeatureSetsQuizView(args);
  } else if (rs.name == TeamInvitationQuizView.routeName) {
    final args = rs.arguments as TIQuizArgs;
    p = TeamInvitationQuizView(args);
  }

  return p != null ? CupertinoPageRoute<dynamic>(builder: (_) => p!, settings: rs) : null;
}

class MTRouteObserver extends NavigatorObserver {
  void _setTitle(Route<dynamic>? route) {
    if (route != null) {
      final rs = route.settings;
      final name = rs.name;
      if (name != null) {
        String title = '';
        if (name == NotificationListView.routeName) {
          title = NotificationListView.title;
        } else if (name == MyProjectsView.routeName) {
          title = MyProjectsView.title;
        } else if (name == MyTasksView.routeName) {
          title = MyTasksView.title;
        } else if (name == SettingsView.routeName) {
          title = SettingsView.title;
        } else if (name == AccountView.routeName) {
          title = AccountView.title;
        } else if (name == UserListView.routeName) {
          title = UserListView.title(rs.arguments as int);
        } else if (name == WorkspaceView.routeName) {
          title = WorkspaceView.title(rs.arguments as int);
        } else if (name == SourceListView.routeName) {
          title = SourceListView.title(rs.arguments as int);
        } else if (name.startsWith(TaskView.routeName)) {
          title = TaskView.title(rs.arguments as TaskController);
        } else if ([CreateTaskQuizView.routeNameProject, CreateTaskQuizView.routeNameGoal].contains(name)) {
          title = CreateTaskQuizView.title(rs.arguments as CreateTaskQuizArgs);
        } else if (name == CreateMultiTaskQuizView.routeName) {
          title = CreateMultiTaskQuizView.title(rs.arguments as CreateMultiTaskQuizArgs);
        } else if (name == MemberView.routeName) {
          title = MemberView.title(rs.arguments as MemberViewArgs);
        } else if (name == UserView.routeName) {
          final user = rs.arguments as User;
          title = UserView.title(user);
        } else if (name == FeatureSetsQuizView.routeName) {
          title = FeatureSetsQuizView.title(rs.arguments as FSQuizArgs);
        } else if (name == TeamInvitationQuizView.routeName) {
          title = TeamInvitationQuizView.title(rs.arguments as TIQuizArgs);
        }

        setPageTitle(title);
      }
    }
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _setTitle(route);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    _setTitle(previousRoute);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _setTitle(newRoute);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _setTitle(previousRoute);
  }
}
