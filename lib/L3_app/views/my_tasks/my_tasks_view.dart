// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/appbar.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/services.dart';
import '../task/controllers/task_controller.dart';
import '../task/widgets/tasks/tasks_list_view.dart';

class MyTasksView extends StatelessWidget {
  static String get routeName => 'my_tasks';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        appBar: appBar(context, middle: BaseText.medium(loc.my_tasks_title)),
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
