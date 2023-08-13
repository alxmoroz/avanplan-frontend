// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../task/widgets/project_create_wizard/project_create_wizard.dart';
import '../task/widgets/tasks_list_view.dart';

class MyProjectsView extends StatelessWidget {
  static String get routeName => 'my_projects';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, middle: MediumText(loc.project_list_title)),
        body: SafeArea(
          top: false,
          bottom: false,
          child: TasksListView(mainController.projectsGroups, TType.ROOT),
        ),
        bottomBar: const Row(children: [
          Spacer(),
          MTPlusButton(projectCreateWizard),
        ]),
      ),
    );
  }
}
