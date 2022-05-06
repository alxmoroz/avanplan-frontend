// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/icons.dart';
import '../../extra/services.dart';
import '../auth/login_view.dart';
import '../goal/goal_dashboard_view.dart';
import '../goal/goal_list_view.dart';
import '../remote_tracker/tracker_list_view.dart';
import '../settings/settings_view.dart';
import '../task/task_view.dart';
import 'main_dashboard_view.dart';

class MainView extends StatefulWidget {
  static String get routeName => 'main';

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final tabViews = [
      MainDashboardView(),
      GoalListView(),
      SettingsView(),
    ];

    return Observer(
      builder: (_) => loginController.authorized
          ? CupertinoTabScaffold(
              tabBar: CupertinoTabBar(
                inactiveColor: inactiveColor,
                backgroundColor: navbarBgColor,
                items: [
                  BottomNavigationBarItem(icon: editIcon(context), label: 'home'),
                  BottomNavigationBarItem(icon: menuIcon(context), label: loc.goal_list_title),
                  BottomNavigationBarItem(icon: linkIcon(context), label: 'settings'),
                ],
              ),
              tabBuilder: (_, index) => CupertinoTabView(
                builder: (_) => tabViews[index],
                routes: {
                  GoalDashboardView.routeName: (_) => GoalDashboardView(),
                  TaskView.routeName: (_) => TaskView(),
                  TrackerListView.routeName: (_) => TrackerListView(),
                },
              ),
            )
          : LoginView(),
    );
  }
}
