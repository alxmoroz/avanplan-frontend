// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/page.dart';
import '../../components/refresh.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/services.dart';
import '../../navigation/route.dart';
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
          builder: (_, state) => ProjectsView(key: state.pageKey),
        );

  @override
  List<RouteBase> get routes => [
        InboxRoute(parent: this),
        ProjectRoute(parent: this),
      ];

  @override
  String title(GoRouterState state) => loc.project_list_title;
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

  Widget get _bigTitle => MTAdaptive(
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: Container(
          height: P8,
          alignment: Alignment.centerLeft,
          child: H1(loc.project_list_title, color: f2Color),
        ),
      );

  bool get _showProjects =>
      tasksMainController.hasOpenedProjects || (tasksMainController.projects.isNotEmpty && _createProjectController.showClosedProjects);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final big = isBigScreen(context);
      final body = MTRefresh(
        onRefresh: tasksMainController.reload,
        child: ListView(
          controller: isWeb ? _scrollController : null,
          children: [
            _bigTitle,
            _showProjects ? TasksListView(tasksMainController.projectsGroups) : NoProjects(_createProjectController),
          ],
        ),
      );
      return MTPage(
        key: widget.key,
        navBar: big
            ? _hasScrolled
                ? MTTopBar(leading: const SizedBox(), middle: _bigTitle)
                : null
            : MTNavBar(pageTitle: _hasScrolled ? loc.project_list_title : null),
        leftBar: big ? LeftMenu(leftMenuController) : null,
        body: body,
        bottomBar: _showProjects
            ? canShowVerticalBars(context)
                ? null
                : MTBottomBar(trailing: CreateProjectButton(_createProjectController, compact: true, type: ButtonType.secondary))
            : null,
        rightBar: _showProjects
            ? canShowVerticalBars(context)
                ? ProjectsRightToolbar(rightToolbarController)
                : null
            : null,
        scrollController: _scrollController,
        scrollOffsetTop: big ? P4 : P8,
        onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
      );
    });
  }
}
