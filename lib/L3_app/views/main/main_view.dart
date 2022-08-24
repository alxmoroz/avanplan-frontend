// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task_ext_state.dart';
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
  bool get showTasksTabview => mainController.rootTask.hasOpenedSubtasks;

  List<Widget> get tabViews {
    final res = <Widget>[MainDashboardView()];
    if (showTasksTabview) {
      res.add(TaskView());
    }
    res.add(SettingsView());

    return res;
  }

  Widget buildTabScaffold() => Observer(
        builder: (_) => CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            inactiveColor: inactiveColor,
            backgroundColor: navbarBgColor,
            items: [
              BottomNavigationBarItem(icon: homeIcon(context)),
              if (showTasksTabview) BottomNavigationBarItem(icon: tasksIcon(context)),
              BottomNavigationBarItem(icon: menuIcon(context)),
            ],
          ),
          tabBuilder: (_, index) => CupertinoTabView(
            builder: (context) => tabViews[index],
            routes: {
              TaskView.routeName: (_) => TaskView(),
              SourceListView.routeName: (_) => SourceListView(),
            },
          ),
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
