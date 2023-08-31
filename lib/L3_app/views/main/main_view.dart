// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../notification/notification_list_view.dart';
import '../settings/settings_view.dart';
import '../task/widgets/project_create_wizard/project_create_wizard.dart';
import 'widgets/main_dashboard.dart';
import 'widgets/no_projects.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  void _startupActions() => WidgetsBinding.instance.addPostFrameCallback((_) async => await mainController.startupActions());

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

  Widget? get _bottomBar => !mainController.hasOpenedProjects
      ? MTButton.main(
          titleText: loc.state_no_projects_action_title,
          onTap: projectCreateWizard,
        )
      : null;

  static const _iconSize = P6;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: accountController.user != null
              ? MTButton.icon(
                  accountController.user!.icon(_iconSize / 2, borderColor: mainColor),
                  onTap: () async => await Navigator.of(context).pushNamed(SettingsView.routeName),
                  padding: const EdgeInsets.only(left: P3),
                )
              : null,
          middle: H1(loc.app_title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (accountController.user != null)
                MTButton.icon(
                  BellIcon(size: _iconSize, hasUnread: notificationController.hasUnread, color: mainColor),
                  onTap: () async => await Navigator.of(context).pushNamed(NotificationListView.routeName),
                ),
              MTButton.icon(
                const RefreshIcon(size: _iconSize),
                onTap: mainController.manualUpdate,
                padding: const EdgeInsets.only(left: P, right: P3),
              ),
            ],
          ),
        ),
        body: SafeArea(
          top: dashboardBigScreen(context),
          bottom: false,
          child: mainController.hasOpenedProjects ? MainDashboard() : NoProjects(),
        ),
        bottomBar: _bottomBar,
      ),
    );
  }
}
