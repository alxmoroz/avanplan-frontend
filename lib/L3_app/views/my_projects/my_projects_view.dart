// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../components/page.dart';
import '../../extra/services.dart';
import '../task/widgets/create/project_create_wizard.dart';
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
        bottomBar: const Row(children: [
          Spacer(),
          MTPlusButton(projectCreateWizard),
        ]),
      ),
    );
  }
}
