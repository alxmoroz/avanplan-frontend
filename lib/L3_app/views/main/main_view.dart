// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/colors.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../my_tasks/my_tasks_view.dart';
import '../projects/create_project_controller.dart';
import '../projects/projects_view.dart';
import '../settings/settings_menu.dart';
import 'widgets/main_dashboard.dart';
import 'widgets/main_menu.dart';
import 'widgets/no_projects.dart';

class MainRouter extends MTRouter {
  @override
  Widget get page => MainView();
}

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  void _startupActions() => WidgetsBinding.instance.addPostFrameCallback((_) async {
        // await setWebpageTitle('');
        await mainController.startupActions();
      });

  @override
  void initState() {
    _startupActions();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _startupActions();
    }
  }

  @override
  void dispose() {
    mainController.clearData();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => loader.loading
          ? Container()
          : MTPage(
              body: SafeArea(
                top: false,
                bottom: false,
                child: tasksMainController.hasOpenedProjects ? MainDashboard() : NoProjects(CreateProjectController()),
              ),
              leftBar: MainMenu(),
              bottomBar: showSideMenu
                  ? null
                  : MTAppBar(
                      isBottom: true,
                      bgColor: b2Color,
                      paddingTop: 0,
                      middle: Row(
                        children: [
                          if (tasksMainController.projects.isNotEmpty)
                            Flexible(
                              child: MTListTile(
                                middle: const ProjectsIcon(color: mainColor, size: P6),
                                padding: const EdgeInsets.only(top: P2),
                                color: Colors.transparent,
                                bottomDivider: false,
                                onTap: () => MTRouter.navigate(ProjectsRouter, context),
                              ),
                            ),
                          if (tasksMainController.myTasks.isNotEmpty)
                            Flexible(
                              child: MTListTile(
                                middle: const TasksIcon(color: mainColor, size: P6),
                                padding: const EdgeInsets.only(top: P2),
                                color: Colors.transparent,
                                bottomDivider: false,
                                onTap: () => MTRouter.navigate(MyTasksRouter, context),
                              ),
                            ),
                          if (accountController.user != null)
                            Flexible(
                              child: MTListTile(
                                middle: accountController.user!.icon(P6 / 2, borderColor: mainColor),
                                padding: const EdgeInsets.only(top: P2),
                                color: Colors.transparent,
                                bottomDivider: false,
                                onTap: showSettingsMenu,
                              ),
                            ),
                          Flexible(
                            child: MTListTile(
                              middle: const RefreshIcon(size: P6),
                              padding: const EdgeInsets.only(top: P2),
                              color: Colors.transparent,
                              bottomDivider: false,
                              onTap: mainController.manualUpdate,
                            ),
                          ),
                        ],
                      ),
                    ),
            ),
    );
  }
}
