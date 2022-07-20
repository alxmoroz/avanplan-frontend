// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/colors.dart';
import '../../components/icons.dart';
import '../../components/splash.dart';
import '../../extra/services.dart';
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
  final tabViews = [
    MainDashboardView(),
    TaskView(),
    SettingsView(),
  ];

  Widget buildTabScaffold() => CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          inactiveColor: inactiveColor,
          backgroundColor: navbarBgColor,
          items: [
            BottomNavigationBarItem(icon: homeIcon(context)),
            BottomNavigationBarItem(icon: tasksIcon(context)),
            BottomNavigationBarItem(icon: menuIcon(context)),
          ],
        ),
        tabBuilder: (_, index) => CupertinoTabView(
          builder: (context) => tabViews[index],
          routes: {
            TaskView.routeName: (_) => TaskView(),
            TrackerListView.routeName: (_) => TrackerListView(),
          },
        ),
      );

  final Future<void> _fetchData = mainController.fetchData();

  @override
  void dispose() {
    mainController.clearData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData,
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done ? buildTabScaffold() : const SplashScreen(),
    );
  }
}
