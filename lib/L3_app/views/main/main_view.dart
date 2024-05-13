// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/page.dart';
import '../../components/refresh.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../components/vertical_toolbar_controller.dart';
import '../../extra/route.dart';
import '../../extra/services.dart';
import '../_base/loader_screen.dart';
import '../account/account_dialog.dart';
import '../app/app_title.dart';
import '../auth/auth_view.dart';
import '../notification/notifications_dialog.dart';
import '../projects/create_project_controller.dart';
import '../projects/projects_view.dart';
import '../task/task_route.dart';
import '../workspace/ws_dialog.dart';
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

class _MainRoute extends MTRoute {
  _MainRoute()
      : super(
          baseName: 'main',
          path: '/',
          redirect: (_, __) => !authController.authorized ? authRoute.path : null,
          controller: mainController,
          noTransition: true,
          builder: (_, __) => const _MainView(),
        );

  @override
  List<RouteBase> get routes => [
        AccountRoute(parent: this),
        NotificationsRoute(parent: this),
        WSRoute(parent: this),
        ProjectsRoute(parent: this),
        InboxRoute(parent: this),
        ProjectRoute(parent: this),
        GoalRoute(parent: this),
        BacklogRoute(parent: this),
        TaskRoute(parent: this),
      ];
}

final mainRoute = _MainRoute();

class _MainView extends StatefulWidget {
  const _MainView();

  @override
  State<StatefulWidget> createState() => _MainViewState();
}

class _MainViewState extends State<_MainView> with WidgetsBindingObserver {
  late final ScrollController _scrollController;
  bool _hasScrolled = false;

  bool get _hasTasks => tasksMainController.myTasks.isNotEmpty;
  bool get _hasEvents => calendarController.events.isNotEmpty;
  bool get _freshStart => tasksMainController.freshStart;

  bool get _showTasks => _hasTasks || _hasEvents;

  @override
  void initState() {
    mainController.startup();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    leftMenuController = VerticalToolbarController(isCompact: !isBigScreen(context), wideWidth: 242.0);
    rightToolbarController = VerticalToolbarController(isCompact: true, wideWidth: 220);
    taskGroupToolbarController = VerticalToolbarController(isCompact: true);
    taskToolbarController = VerticalToolbarController(isCompact: false);

    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      mainController.startup();
    }
  }

  @override
  void dispose() {
    mainController.clear();
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  Widget get _bigTitle => Align(
        alignment: Alignment.centerLeft,
        child: H1(loc.my_tasks_upcoming_title, padding: const EdgeInsets.symmetric(horizontal: P3), maxLines: 1),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final big = isBigScreen(context);
        return appController.loading
            ? LoaderScreen(appController)
            : mainController.loading
                ? LoaderScreen(mainController)
                : MTPage(
                    appBar: !_freshStart
                        ? MTAppBar(
                            leading: const SizedBox(height: P8),
                            color: big
                                ? _hasScrolled
                                    ? b2Color
                                    : Colors.transparent
                                : null,
                            middle: _hasScrolled
                                ? big
                                    ? _bigTitle
                                    : H3(loc.my_tasks_upcoming_title, maxLines: 1)
                                : null,
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
                      child: MTRefresh(
                        onRefresh: mainController.reload,
                        child: _showTasks
                            ? ListView(
                                controller: isWeb ? _scrollController : null,
                                children: [
                                  _bigTitle,
                                  const SizedBox(height: P3),
                                  const NextTasks(),
                                ],
                              )
                            : NoTasks(CreateProjectController()),
                      ),
                    ),
                    leftBar: canShowVerticalBars(context) ? LeftMenu(leftMenuController) : null,
                    rightBar: big && !_freshStart ? MainRightToolbar(rightToolbarController) : null,
                    bottomBar: canShowVerticalBars(context) ? null : const BottomMenu(),
                    scrollController: _scrollController,
                    scrollOffsetTop: P8,
                    onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
                  );
      },
    );
  }
}
