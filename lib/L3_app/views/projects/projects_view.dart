// Copyright (c) 2024. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';

import '../../../L2_data/services/platform.dart';
import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/constants.dart';
import '../../components/list_tile.dart';
import '../../components/page.dart';
import '../../components/refresh.dart';
import '../../components/scrollable_centered.dart';
import '../../components/toolbar.dart';
import '../../navigation/route.dart';
import '../../theme/colors.dart';
import '../../theme/text.dart';
import '../app/services.dart';
import '../main/main_view.dart';
import '../main/widgets/left_menu.dart';
import '../task/task_route.dart';
import '../task/widgets/tasks/tasks_list_view.dart';
import 'create_project_button.dart';
import 'creation_big_buttons.dart';
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

  bool _hasScrolled = false;
  bool _showClosedProjects = false;

  @override
  void initState() {
    _scrollController = ScrollController();
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

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final big = isBigScreen(context);
      final showProjects = tasksMainController.hasOpenedProjects || (tasksMainController.projects.isNotEmpty && _showClosedProjects);
      final hasVertBars = showProjects && canShowVerticalBars(context);

      return MTPage(
        key: widget.key,
        navBar: big
            ? _hasScrolled
                ? MTTopBar(leading: const SizedBox(), middle: _bigTitle)
                : null
            : MTNavBar(pageTitle: _hasScrolled || !showProjects ? loc.project_list_title : null),
        leftBar: big ? LeftMenu(leftMenuController) : null,
        body: MTRefresh(
          onRefresh: tasksMainController.reload,
          child: showProjects
              ? ListView(
                  controller: isWeb ? _scrollController : null,
                  children: [_bigTitle, TasksListView(tasksMainController.projectsGroups)],
                )
              : MTScrollableCentered(
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MTListText.h2(
                        tasksMainController.isAllProjectsClosed ? loc.project_list_empty_all_closed_title : loc.lets_get_started,
                        titleTextAlign: TextAlign.center,
                        titleTextColor: f2Color,
                      ),
                      const SizedBox(height: DEF_VP * 3),
                      const CreationProjectBigButtons(),
                      if (tasksMainController.isAllProjectsClosed)
                        MTButton.secondary(
                          titleText: loc.action_show_closed_title,
                          margin: const EdgeInsets.only(top: DEF_VP * 3),
                          onTap: () => setState(() => _showClosedProjects = true),
                        )
                      else
                        const SizedBox(height: DEF_BAR_HEIGHT),
                    ],
                  ),
                ),
        ),
        bottomBar: showProjects
            ? hasVertBars
                ? null
                : const MTBottomBar(trailing: CreateProjectButton(compact: true, type: MTButtonType.secondary))
            : null,
        rightBar: showProjects
            ? hasVertBars
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
