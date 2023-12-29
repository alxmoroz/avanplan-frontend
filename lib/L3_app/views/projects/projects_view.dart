// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/button.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../main/widgets/left_menu.dart';
import '../task/widgets/tasks/tasks_list_view.dart';
import 'create_project_button.dart';
import 'create_project_controller.dart';
import 'right_toolbar.dart';
import 'right_toolbar_controller.dart';

class ProjectsRouter extends MTRouter {
  @override
  String get path => '/projects';

  @override
  String get title => loc.project_list_title;

  @override
  Widget get page => ProjectsView();
}

class ProjectsView extends StatefulWidget {
  @override
  _ProjectsViewState createState() => _ProjectsViewState();
}

class _ProjectsViewState extends State<ProjectsView> {
  late final ProjectsRightToolbarController _toolbarController;
  late final ScrollController _scrollController;
  bool _hasScrolled = false;

  @override
  void initState() {
    _toolbarController = ProjectsRightToolbarController();
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget get _bigTitle => Align(
        alignment: Alignment.centerLeft,
        child: H1(loc.project_list_title, padding: const EdgeInsets.symmetric(horizontal: P3)),
      );

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
                  : BaseText.medium(loc.project_list_title)
              : null,
        ),
        leftBar: big ? const LeftMenu() : null,
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            controller: kIsWeb ? _scrollController : null,
            children: [
              _bigTitle,
              const SizedBox(height: P3),
              TasksListView(tasksMainController.projectsGroups, scrollable: false),
            ],
          ),
        ),
        bottomBar: canShowVerticalBars(context)
            ? null
            : MTAppBar(
                isBottom: true,
                padding: const EdgeInsets.only(top: P2),
                color: b2Color,
                trailing: CreateProjectButton(CreateProjectController(), compact: true, type: ButtonType.secondary),
              ),
        rightBar: canShowVerticalBars(context) ? ProjectsRightToolbar(_toolbarController) : null,
        scrollController: _scrollController,
        scrollOffsetTop: P8,
        onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
      );
    });
  }
}
