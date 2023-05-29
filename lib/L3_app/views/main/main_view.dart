// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../main.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_state.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/task_level_presenter.dart';
import '../notification/notification_list_view.dart';
import '../settings/settings_view.dart';
import '../task/panes/overview_pane.dart';
import '../task/project_add_wizard/project_add_wizard.dart';
import '../task/task_view.dart';
import '../task/task_view_controller.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  // TODO: немного странно тут. Возможно, дело в возможности передачи id задачи дальше в подвиджеты
  TaskViewController get rootTaskController => TaskViewController(-1, null);
  Task get rootTask => mainController.rootTask;

  void startupActions() => WidgetsBinding.instance.addPostFrameCallback((_) async => await mainController.startupActions());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    startupActions();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      startupActions();
    }
  }

  @override
  void dispose() {
    mainController.clearData();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future toSettings() async => await Navigator.of(rootKey.currentContext!).pushNamed(SettingsView.routeName);
  Future toProjects() async =>
      await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: TaskViewArgs(rootTask.wsId, null));
  Future toMessages() async => await Navigator.of(rootKey.currentContext!).pushNamed(NotificationListView.routeName);

  Widget get noOpenedProjects {
    final iconSize = MediaQuery.of(context).size.height / 5;
    final allClosed = rootTask.hasSubtasks;
    return ListView(
      shrinkWrap: true,
      children: [
        const SizedBox(height: P2),
        Center(child: allClosed ? OkIcon(size: iconSize) : StartIcon(size: iconSize)),
        const SizedBox(height: P2),
        if (allClosed)
          MTButton(
            leading: H3(loc.project_list_title, color: mainColor),
            middle: H3(loc.are_closed_suffix),
            onTap: toProjects,
          ),
        const SizedBox(height: P),
        H3(
          loc.projects_add_hint_title,
          align: TextAlign.center,
          padding: const EdgeInsets.symmetric(horizontal: P2),
          maxLines: 5,
        ),
        const SizedBox(height: P2),
      ],
    );
  }

  Widget? get _bottomBar => Padding(
        padding: const EdgeInsets.only(bottom: P),
        child: rootTask.hasOpenedSubtasks
            ? MTButton.main(
                titleText: loc.project_list_title,
                onTap: toProjects,
              )
            : MTButton.main(
                leading: const PlusIcon(color: lightBackgroundColor),
                titleText: rootTask.newSubtaskTitle,
                onTap: projectAddWizard,
              ),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: accountController.user != null
              ? MTButton.icon(
                  accountController.user!.icon(20, borderSide: const BorderSide(color: mainColor)),
                  toSettings,
                  margin: const EdgeInsets.only(left: P),
                )
              : null,
          middle: H2(loc.app_title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (accountController.user != null)
                MTButton.icon(
                  BellIcon(size: P3, hasUnread: notificationController.hasUnread, color: mainColor),
                  toMessages,
                  margin: const EdgeInsets.only(right: P),
                ),
              MTButton.icon(
                const RefreshIcon(size: P3),
                mainController.manualUpdate,
                margin: const EdgeInsets.only(right: P),
              ),
            ],
          ),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: rootTask.hasOpenedSubtasks ? OverviewPane(rootTaskController) : noOpenedProjects,
          ),
        ),
        bottomBar: _bottomBar,
      ),
    );
  }
}
