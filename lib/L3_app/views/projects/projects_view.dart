// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
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

  Widget get _bigTitle => Align(
        alignment: Alignment.centerLeft,
        child: H1(loc.project_list_title, padding: const EdgeInsets.symmetric(horizontal: P3)),
      );

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return MTPage(
        appBar: MTAppBar(
          bgColor: isBigScreen ? b2Color : null,
          leading: isBigScreen ? const SizedBox() : null,
          middle: _hasScrolled
              ? isBigScreen
                  ? _bigTitle
                  : BaseText.medium(loc.project_list_title)
              : null,
        ),
        leftBar: const LeftMenu(),
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
        bottomBar: isBigScreen
            ? null
            : MTAppBar(
                isBottom: true,
                bgColor: b2Color,
                trailing: CreateProjectButton(CreateProjectController(), compact: true, type: ButtonType.secondary),
              ),
        rightBar: isBigScreen ? ProjectsRightToolbar(_toolbarController) : null,
        scrollController: _scrollController,
        scrollOffsetTop: P8,
        onScrolled: (scrolled) => setState(() => _hasScrolled = scrolled),
      );
    });
  }
}
