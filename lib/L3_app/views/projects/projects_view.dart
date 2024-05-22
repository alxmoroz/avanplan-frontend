// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/refresh.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/route.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../main/main_view.dart';
import '../main/widgets/left_menu.dart';
import '../task/task_route.dart';
import '../task/widgets/tasks/tasks_list_view.dart';
import 'create_project_button.dart';
import 'create_project_controller.dart';
import 'no_projects.dart';
import 'right_toolbar.dart';

class ProjectsRoute extends MTRoute {
  static const staticBaseName = 'projects';

  ProjectsRoute({super.parent})
      : super(
          path: staticBaseName,
          baseName: staticBaseName,
          builder: (_, __) => const ProjectsView(),
        );

  @override
  List<RouteBase> get routes => [
        InboxRoute(parent: this),
        ProjectRoute(parent: this),
      ];

  @override
  String? title(GoRouterState state) => loc.project_list_title;
}

class ProjectsView extends StatefulWidget {
  const ProjectsView({super.key});

  @override
  State<StatefulWidget> createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  late final ScrollController _scrollController;
  late final CreateProjectController _createProjectController;
  bool _hasScrolled = false;

  @override
  void initState() {
    _scrollController = ScrollController();
    _createProjectController = CreateProjectController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget get _bigTitle => Align(
        alignment: Alignment.centerLeft,
        child: H1(loc.project_list_title, padding: const EdgeInsets.symmetric(horizontal: P3), maxLines: 1),
      );

  Task? get _inbox => tasksMainController.inbox;
  bool get _showProjects => tasksMainController.hasOpenedProjects || (tasksMainController.projects.isNotEmpty && _createProjectController.showClosed);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final big = isBigScreen(context);
      return MTPage(
        appBar: MTAppBar(
          color: big
              ? _hasScrolled
                  ? b2Color
                  : Colors.transparent
              : null,
          leading: big ? const SizedBox() : null,
          middle: _hasScrolled
              ? big
                  ? _bigTitle
                  : H3(loc.project_list_title, maxLines: 1)
              : null,
        ),
        leftBar: big ? LeftMenu(leftMenuController) : null,
        body: SafeArea(
          top: false,
          bottom: false,
          child: MTRefresh(
            onRefresh: tasksMainController.reload,
            child: ListView(
              controller: isWeb ? _scrollController : null,
              children: [
                _bigTitle,
                if (_inbox != null) ...[
                  const SizedBox(height: P3),
                  MTAdaptive(
                    child: MTListTile(
                      leading: const InboxIcon(),
                      titleText: _inbox!.title,
                      trailing: const ChevronIcon(),
                      bottomDivider: false,
                      onTap: () => router.goTaskView(_inbox!),
                    ),
                  ),
                ],
                const SizedBox(height: P3),
                _showProjects ? TasksListView(tasksMainController.projectsGroups) : MTAdaptive(child: NoProjects(_createProjectController)),
              ],
            ),
          ),
        ),
        bottomBar: _showProjects
            ? canShowVerticalBars(context)
                ? null
                : MTAppBar(
                    isBottom: true,
                    padding: const EdgeInsets.only(top: P2),
                    color: b2Color,
                    trailing: CreateProjectButton(_createProjectController, compact: true, type: ButtonType.secondary),
                  )
            : null,
        rightBar: _showProjects
            ? canShowVerticalBars(context)
                ? ProjectsRightToolbar(rightToolbarController)
                : null
            : null,
        scrollController: _scrollController,
        scrollOffsetTop: P8,
        onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
      );
    });
  }
}
