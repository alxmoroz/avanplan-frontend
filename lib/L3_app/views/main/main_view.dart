// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors.dart';
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
import '../../presenters/user.dart';
import '../_base/loader_screen.dart';
import '../account/account_dialog.dart';
import '../auth/auth_view.dart';
import '../notification/notifications_dialog.dart';
import '../projects/create_project_controller.dart';
import '../projects/projects_view.dart';
import '../settings/settings_menu.dart';
import '../task/task_route.dart';
import '../task/widgets/empty_state/task_404_dialog.dart';
import '../workspace/ws_route.dart';
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

class MainRoute extends MTRoute {
  MainRoute()
      : super(
          baseName: 'main',
          path: '/',
          redirect: (_, state) {
            if (state.uri.hasQuery) localSettingsController.parseMainQuery(state.uri);
            return !authController.authorized ? authRoute.path : null;
          },
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
        Task404Route(parent: this),
      ];
}

final mainRoute = MainRoute();

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
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    super.dispose();
  }

  Widget get _bigTitle => MTAdaptive(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: H1(loc.my_tasks_upcoming_title, maxLines: 1, color: f2Color),
      );

  Widget get _settingsButton => MTButton.icon(
        accountController.me!.icon(P6 / 2, borderColor: mainColor),
        padding: const EdgeInsets.symmetric(horizontal: P2),
        onTap: settingsMenu,
      );

  Widget _page(BuildContext context) {
    final big = isBigScreen(context);
    final canShowVertBars = canShowVerticalBars(context);
    final appBarLeading = accountController.me != null && !big && !canShowVertBars ? _settingsButton : const SizedBox(height: P8);
    return MTPage(
      appBar: MTAppBar(
        leading: appBarLeading,
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
        trailing: isWeb || big
            ? null
            : const MTButton.icon(
                SettingsIcon(),
                padding: EdgeInsets.symmetric(horizontal: P2),
                onTap: showViewSettingsDialog,
              ),
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: MTRefresh(
          onRefresh: mainController.reload,
          child: ListView(
            controller: isWeb ? _scrollController : null,
            shrinkWrap: _freshStart,
            children: [
              _bigTitle,
              _showTasks ? const NextTasks() : NoTasks(CreateProjectController()),
            ],
          ),
        ),
      ),
      leftBar: canShowVertBars ? LeftMenu(leftMenuController) : null,
      rightBar: big && !_freshStart ? MainRightToolbar(rightToolbarController) : null,
      bottomBar: canShowVertBars ? null : const BottomMenu(),
      scrollController: _scrollController,
      scrollOffsetTop: P8,
      onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => appController.loading
          ? LoaderScreen(appController)
          : mainController.loading
              ? LoaderScreen(mainController)
              : _page(context),
    );
  }
}
