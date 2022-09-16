// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/colors.dart';
import '../../components/icons.dart';
import '../../components/splash.dart';
import '../../extra/services.dart';
import '../settings/settings_view.dart';
import '../source/source_list_view.dart';
import '../task/task_view.dart';
import 'main_dashboard_view.dart';

class MainView extends StatefulWidget {
  static String get routeName => 'main';

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Widget> get tabViews => [MainDashboardView(), TaskView(null), SettingsView()];

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
          onGenerateRoute: (RouteSettings rs) {
            if (rs.name == TaskView.routeName) {
              return CupertinoPageRoute<TaskView>(builder: (_) => TaskView(rs.arguments as int?));
            } else if (rs.name == SourceListView.routeName) {
              return CupertinoPageRoute<SourceListView>(builder: (_) => SourceListView());
            }
          },
        ),
      );

  @override
  void dispose() {
    mainController.clearData();
    super.dispose();
  }

  final Future<void> _fetchData = mainController.updateAll();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData,
      builder: (_, snapshot) => snapshot.connectionState == ConnectionState.done ? buildTabScaffold() : const SplashScreen(),
    );
  }
}
