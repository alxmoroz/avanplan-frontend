// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../usecases/task_ext_actions.dart';
import '../notification/notification_list_view.dart';
import '../settings/settings_view.dart';
import '../task/panes/task_overview.dart';
import '../task/task_view.dart';
import '../task/task_view_controller.dart';
import '../task/widgets/task_add_button.dart';
import '../task/widgets/task_add_menu.dart';
import 'import_projects_actions.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startupActions();
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

  TaskViewController get _taskController => TaskViewController(null);
  Task get _task => _taskController.task;

  void _startupActions() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await authController.updateAuth(context);
      if (authController.authorized) {
        if (isIOS) {
          await notificationController.initPush();
        }
        await mainController.requestUpdate();
      }
    });
  }

  Future _gotoSettings(BuildContext context) async => await Navigator.of(context).pushNamed(SettingsView.routeName);
  Future _gotoProjects(BuildContext context) async => await Navigator.of(context).pushNamed(TaskView.routeName);
  Future _gotoMessages(BuildContext context) async => await Navigator.of(context).pushNamed(NotificationListView.routeName);

  Widget? _bottomBar(BuildContext context) => _task.hasSubtasks
      ? Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: MTButton.outlined(
                titleText: loc.project_list_title,
                margin: EdgeInsets.only(left: P, right: _task.canCreate ? 0 : P),
                onTap: () => _gotoProjects(context),
              ),
            ),
            if (_task.canCreate) TaskAddMenu(_taskController),
          ],
        )
      : _task.canCreate
          ? TaskAddButton(_taskController)
          : null;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: accountController.user != null
              ? MTButton.icon(
                  accountController.user!.icon(20, borderSide: const BorderSide(color: mainColor)),
                  () => _gotoSettings(context),
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
                  () => _gotoMessages(context),
                  margin: const EdgeInsets.only(right: P),
                ),
              MTButton.icon(
                const RefreshIcon(size: P3),
                mainController.manualUpdate,
                margin: const EdgeInsets.only(right: P),
              ),
            ],
          ),
          border: const Border(),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: Center(
            child: !_task.hasOpenedSubtasks ? ImportProjectsActions(_task) : TaskOverview(_taskController),
          ),
        ),
        bottomBar: _bottomBar(context),
      ),
    );
  }
}
