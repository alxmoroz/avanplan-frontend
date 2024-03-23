// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../components/vertical_toolbar_controller.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../app/app_title.dart';
import '../projects/create_project_controller.dart';
import 'widgets/bottom_menu.dart';
import 'widgets/left_menu.dart';
import 'widgets/next_tasks.dart';
import 'widgets/no_tasks.dart';
import 'widgets/right_toolbar.dart';
import 'widgets/view_settings_dialog.dart';

late VerticalToolbarController leftMenuController;
late VerticalToolbarController rightToolbarController;
late VerticalToolbarController taskGroupToolbarController;
late VerticalToolbarController taskToolbarController;

class MainRouter extends MTRouter {
  @override
  Widget get page => const MainView();
}

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> with WidgetsBindingObserver {
  bool get _hasTasks => tasksMainController.myTasks.isNotEmpty;
  bool get _hasEvents => calendarController.events.isNotEmpty;
  bool get _freshStart => tasksMainController.freshStart;

  bool get _showTasks => _hasTasks || _hasEvents;

  void _startupActions() => WidgetsBinding.instance.addPostFrameCallback((_) async {
        leftMenuController = VerticalToolbarController(isCompact: !isBigScreen(context), wideWidth: 242.0);
        rightToolbarController = VerticalToolbarController(isCompact: true, wideWidth: 220);
        taskGroupToolbarController = VerticalToolbarController(isCompact: true);
        taskToolbarController = VerticalToolbarController(isCompact: false);

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
    return Observer(builder: (_) {
      final big = isBigScreen(context);
      return loader.loading
          ? Container()
          : MTPage(
              appBar: !_freshStart
                  ? MTAppBar(
                      leading: const SizedBox(height: P8),
                      color: big ? b2Color : null,
                      middle: H3(loc.my_tasks_upcoming_title, maxLines: 1),
                      trailing: big
                          ? null
                          : const MTButton.icon(
                              SettingsIcon(),
                              padding: EdgeInsets.only(right: P2),
                              onTap: showViewSettingsDialog,
                            ),
                    )
                  : big
                      ? null
                      : const MTAppBar(leading: SizedBox(), middle: AppTitle()),
              body: SafeArea(
                top: false,
                bottom: false,
                child: _showTasks ? const NextTasks() : NoTasks(CreateProjectController()),
              ),
              leftBar: canShowVerticalBars(context) ? LeftMenu(leftMenuController) : null,
              rightBar: big && _showTasks ? MainRightToolbar(rightToolbarController) : null,
              bottomBar: canShowVerticalBars(context) ? null : const BottomMenu(),
            );
    });
  }
}
