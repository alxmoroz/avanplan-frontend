// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/page.dart';
import '../../components/toolbar.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../main/widgets/left_menu.dart';
import '../task/controllers/task_controller.dart';
import '../task/widgets/tasks/tasks_list_view.dart';

class MyTasksRouter extends MTRouter {
  @override
  String get path => '/my_tasks';

  @override
  String get title => loc.my_tasks_title;

  @override
  Widget get page => const MyTasksView();
}

class MyTasksView extends StatelessWidget {
  const MyTasksView();

  @override
  Widget build(BuildContext context) {
    return MTPage(
      appBar: MTAppBar(title: loc.my_tasks_title),
      leftBar: const LeftMenu(),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Observer(
          builder: (_) => TasksListView(
            tasksMainController.myTasksGroups,
            filters: const {TasksFilter.my},
          ),
        ),
      ),
    );
  }
}
