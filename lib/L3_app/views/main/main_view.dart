// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../projects/create_project_controller.dart';
import '../settings/account_btn.dart';
import '../settings/settings_view.dart';
import 'widgets/main_dashboard.dart';
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
              bottomBar: showSideMenu
                  ? null
                  : MTAppBar(
                      isBottom: true,
                      leading: accountController.user != null ? AccountButton(() async => await SettingsRouter().navigate(context)) : null,
                      trailing: MTButton.icon(const RefreshIcon(size: P7), onTap: mainController.manualUpdate),
                    ),
            ),
    );
  }
}
