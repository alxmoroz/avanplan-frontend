// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/adaptive.dart';
import '../../components/page.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../task/widgets/tasks/tasks_list_view.dart';
import 'create_project_button.dart';
import 'create_project_controller.dart';

class ProjectsRouter extends MTRouter {
  @override
  String get path => '/projects';

  @override
  String get title => loc.project_list_title;

  @override
  Widget get page => ProjectsView();
}

class ProjectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // WidgetsBinding.instance.addPostFrameCallback((_) => setWebpageTitle(loc.project_list_title));
    return MTPage(
      appBar: MTAppBar(title: loc.project_list_title),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Observer(builder: (_) => TasksListView(tasksMainController.projectsGroups)),
      ),
      bottomBar: MTAdaptive(
        force: true,
        child: MTAppBar(
          isBottom: true,
          trailing: CreateProjectButton(CreateProjectController(), compact: true),
        ),
      ),
    );
  }
}
