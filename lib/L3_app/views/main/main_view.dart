// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../projects/create_project_controller.dart';
import '../settings/settings_view.dart';
import 'widgets/app_title.dart';
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

  static const _iconSize = P7;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => loader.loading
          ? Container()
          : MTPage(
              appBar: MTAppBar(
                height: P10,
                leading: accountController.user != null
                    ? MTButton.icon(
                        accountController.user!.icon(_iconSize / 2, borderColor: mainColor),
                        onTap: () async => await SettingsRouter().navigate(context),
                        padding: const EdgeInsets.only(left: P3),
                      )
                    : null,
                middle: AppTitle(),
                trailing: MTButton.icon(
                  const RefreshIcon(size: _iconSize),
                  onTap: mainController.manualUpdate,
                  padding: const EdgeInsets.symmetric(horizontal: P3),
                ),
              ),
              body: SafeArea(
                top: false,
                bottom: false,
                child: tasksMainController.hasOpenedProjects ? MainDashboard() : NoProjects(CreateProjectController()),
              ),
            ),
    );
  }
}
