// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/usecases/task_ext_state.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../account/user_icon.dart';
import '../notification/notification_list_view.dart';
import '../settings/settings_view.dart';
import '../task/task_related_widgets/task_add_button.dart';
import '../task/task_related_widgets/task_add_menu.dart';
import '../task/task_view.dart';
import '../task/task_view_controller.dart';
import '../task/task_view_widgets/task_overview.dart';
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
        await notificationController.initPush();
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
                margin: const EdgeInsets.symmetric(horizontal: P),
                onTap: () => _gotoProjects(context),
              ),
            ),
            if (mainController.canEditAnyWS) TaskAddMenu(_taskController),
          ],
        )
      : mainController.canEditAnyWS
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
                  UserIcon(accountController.user!, radius: 20, borderSide: const BorderSide(color: mainColor)),
                  () => _gotoSettings(context),
                  margin: const EdgeInsets.only(left: P),
                )
              : null,
          middle: H2(loc.app_title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              MTButton.icon(
                BellIcon(size: P3, hasUnread: notificationController.hasUnread, color: mainColor),
                () => _gotoMessages(context),
                margin: const EdgeInsets.only(right: P),
              ),
              MTButton.icon(
                const RefreshIcon(size: P3),
                mainController.update,
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
            child: !_task.hasOpenedSubtasks ? ImportProjectsActions(_task) : TaskOverview(_task),
          ),
        ),
        bottomBar: _bottomBar(context),
      ),
    );
  }
}
