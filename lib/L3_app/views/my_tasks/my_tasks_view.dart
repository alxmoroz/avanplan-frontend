// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/appbar.dart';
import '../../components/page.dart';
import '../../extra/services.dart';
import '../task/controllers/task_controller.dart';
import '../task/widgets/tasks/tasks_list_view.dart';

class MyTasksView extends StatelessWidget {
  static String get routeName => '/my_tasks';
  static String get title => loc.my_tasks_title;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: MTAppBar(context, title: title),
        body: SafeArea(
          top: false,
          bottom: false,
          child: TasksListView(
            tasksMainController.myTasksGroups,
            filters: const {TasksFilter.my},
          ),
        ),
      ),
    );
  }
}
