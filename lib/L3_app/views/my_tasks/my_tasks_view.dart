// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/navbar.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../task/controllers/task_controller.dart';
import '../task/widgets/tasks_list_view.dart';

class MyTasksView extends StatelessWidget {
  static String get routeName => 'my_tasks';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(context, middle: MediumText(loc.my_tasks_title)),
        body: SafeArea(
          top: false,
          bottom: false,
          child: TasksListView(
            mainController.myTasksGroups,
            filters: const {TasksFilter.my},
          ),
        ),
      ),
    );
  }
}
