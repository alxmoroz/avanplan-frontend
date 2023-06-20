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
import '../../components/images.dart';
import '../../components/mt_button.dart';
import '../../components/mt_card.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/person_presenter.dart';
import '../../presenters/task_level_presenter.dart';
import '../../presenters/task_state_presenter.dart';
import '../notification/notification_list_view.dart';
import '../settings/settings_view.dart';
import '../task/project_add_wizard/project_add_wizard.dart';
import '../task/task_view.dart';
import '../task/task_view_controller.dart';

class MainView extends StatefulWidget {
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  TaskViewController get rootTaskController => TaskViewController();
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

  Future toSettings() async => await Navigator.of(rootKey.currentContext!).pushNamed(SettingsView.routeName);
  Future toProjects() async => await Navigator.of(rootKey.currentContext!).pushNamed(TaskView.routeName, arguments: TaskParams(rootTask.wsId));
  Future toMessages() async => await Navigator.of(rootKey.currentContext!).pushNamed(NotificationListView.routeName);

  Widget _cardButton(Widget child, VoidCallback onTap) => MTCardButton(
        child: child,
        elevation: cardElevation,
        onTap: onTap,
      );

  Widget get _noOpenedProjects {
    final iconSize = MediaQuery.of(context).size.height / 4;
    final allClosed = rootTask.hasSubtasks;
    return Center(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          MTImage(allClosed ? ImageNames.ok : ImageNames.start, size: iconSize),
          const SizedBox(height: P),
          if (allClosed)
            MTButton(
              leading: H2(loc.project_list_all_title, color: mainColor),
              middle: H2(loc.are_closed_suffix),
              onTap: toProjects,
            )
          else
            H2(loc.state_no_projects_hint, align: TextAlign.center),
          const SizedBox(height: P),
          H3(
            loc.projects_add_hint_title,
            align: TextAlign.center,
            padding: const EdgeInsets.symmetric(horizontal: P2),
            maxLines: 5,
          ),
          const SizedBox(height: P),
        ],
      ),
    );
  }

  Widget? get _bottomBar => !rootTask.hasOpenedSubtasks
      ? MTButton.main(
          leading: const PlusIcon(color: lightBackgroundColor),
          titleText: rootTask.newSubtaskTitle,
          onTap: projectAddWizard,
        )
      : null;

  static const _iconSize = P3;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          leading: accountController.user != null
              ? MTButton.icon(
                  accountController.user!.icon(_iconSize / 2, borderSide: const BorderSide(color: mainColor)),
                  toSettings,
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
                  toMessages,
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
          top: false,
          bottom: false,
          child: rootTask.hasOpenedSubtasks
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: P3).copyWith(top: mq.orientation == Orientation.portrait ? P2 : P_2),
                  child: GridView(
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: SCR_S_WIDTH,
                      mainAxisSpacing: P2,
                      crossAxisSpacing: P2,
                    ),
                    children: [
                      _cardButton(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            NormalText(loc.task_list_my_title, align: TextAlign.center, color: lightGreyColor),
                            const Spacer(),
                            D1('${mainController.myUpcomingTasksCount}', align: TextAlign.center, color: mainColor),
                            const Spacer(),
                            H2(mainController.myUpcomingTasksTitle, align: TextAlign.center),
                            const SizedBox(height: P),
                          ],
                        ),
                        () {},
                      ),
                      _cardButton(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            NormalText(loc.project_list_my_title, align: TextAlign.center, color: lightGreyColor),
                            Expanded(
                              child: Column(
                                children: [
                                  const Spacer(),
                                  imageForState(rootTask.overallState, size: MediaQuery.of(context).size.height / 4),
                                  const Spacer(),
                                  H2(rootTask.groupStateTitle(rootTask.subtasksState), align: TextAlign.center),
                                  const SizedBox(height: P),
                                ],
                              ),
                            ),
                          ],
                        ),
                        toProjects,
                      ),
                    ],
                  ),
                )
              : _noOpenedProjects,
        ),
        bottomBar: _bottomBar,
      ),
    );
  }
}
