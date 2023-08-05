// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../task/task_view_controller.dart';
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
            TType.ROOT,
            filters: const {TasksFilter.my},
          ),
        ),
      ),
    );
  }
}
