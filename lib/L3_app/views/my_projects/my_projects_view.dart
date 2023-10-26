// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/appbar.dart';
import '../../components/page.dart';
import '../../extra/services.dart';
import '../task/controllers/create_project_controller.dart';
import '../task/widgets/create/create_project_button.dart';
import '../task/widgets/create/import_project_button.dart';
import '../task/widgets/tasks/tasks_list_view.dart';

class MyProjectsView extends StatelessWidget {
  static String get routeName => '/my_projects';
  static String get title => loc.project_list_title;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(context, title: title),
        body: SafeArea(
          top: false,
          bottom: false,
          child: TasksListView(tasksMainController.projectsGroups),
        ),
        bottomBar: Row(children: [
          const Spacer(),
          ImportProjectButton(CreateProjectController(), compact: true, secondary: true),
          CreateProjectButton(CreateProjectController(), compact: true),
        ]),
      ),
    );
  }
}
