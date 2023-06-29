// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_stats.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_adaptive.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../notification/notification_list_view.dart';
import '../settings/settings_view.dart';
import '../task/project_add_wizard/project_add_wizard.dart';
import 'widgets/my_projects.dart';
import 'widgets/my_tasks.dart';
import 'widgets/no_projects.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  Task get rootTask => mainController.rootTask;

  void _startupActions() => WidgetsBinding.instance.addPostFrameCallback((_) async {
        await mainController.startupActions();
        if (loader.loading && loader.actionWidget == null) {
          await loader.stop();
        }
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

  Widget? get _bottomBar => !rootTask.hasOpenedSubtasks
      ? MTButton.main(
          titleText: loc.state_no_projects_action_title,
          onTap: projectAddWizard,
        )
      : null;

  static const _iconSize = P3;

  @override
  Widget build(BuildContext context) {
    final _mq = MediaQuery.of(context);
    final _bigScreen = _mq.size.width > SCR_L_WIDTH && _mq.size.height > SCR_S_HEIGHT;
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: accountController.user != null
              ? MTButton.icon(
                  accountController.user!.icon(_iconSize / 2, borderSide: const BorderSide(color: mainColor)),
                  () async => await Navigator.of(context).pushNamed(SettingsView.routeName),
                  padding: const EdgeInsets.only(left: P2, right: P),
                )
              : null,
          middle: H1(loc.app_title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (accountController.user != null)
                MTButton.icon(
                  BellIcon(size: _iconSize, hasUnread: notificationController.hasUnread, color: mainColor),
                  () async => await Navigator.of(context).pushNamed(NotificationListView.routeName),
                  padding: const EdgeInsets.only(left: P, right: P_2),
                ),
              MTButton.icon(
                const RefreshIcon(size: _iconSize),
                mainController.manualUpdate,
                padding: const EdgeInsets.only(left: P_2, right: P2),
              ),
            ],
          ),
        ),
        body: SafeArea(
          top: _bigScreen,
          bottom: _bigScreen,
          child: rootTask.hasOpenedSubtasks
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: P3, vertical: _mq.orientation == Orientation.portrait ? P2 : P_2),
                  child: _bigScreen
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MTAdaptive.S(MyTasks()),
                            SizedBox(width: P3),
                            MTAdaptive.S(MyProjects()),
                          ],
                        )
                      : GridView(
                          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: SCR_S_WIDTH,
                            mainAxisSpacing: P2,
                            crossAxisSpacing: P2,
                          ),
                          children: const [
                            MyTasks(card: true),
                            MyProjects(card: true),
                          ],
                        ),
                )
              : NoProjects(),
        ),
        bottomBar: _bottomBar,
      ),
    );
  }
}
