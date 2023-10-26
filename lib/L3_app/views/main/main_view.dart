// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../extra/services.dart';
import '../../presenters/person.dart';
import '../settings/settings_view.dart';
import '../task/controllers/create_project_controller.dart';
import '../task/widgets/empty_state/no_projects.dart';
import 'widgets/app_title.dart';
import 'widgets/main_dashboard.dart';

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

  static const _iconSize = P7;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(
          context,
          leadingWidth: _iconSize + P3,
          leading: accountController.user != null
              ? MTButton.icon(
                  accountController.user!.icon(_iconSize / 2, borderColor: mainColor),
                  onTap: () async => await Navigator.of(context).pushNamed(SettingsView.routeName),
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
