// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../components/colors.dart';
import '../../../components/constants.dart';
import '../../../components/images.dart';
import '../../../components/text_widgets.dart';
import '../../../extra/services.dart';
import '../../task/task_view.dart';
import '../../task/task_view_controller.dart';
import 'dashboard_wrapper.dart';

class MyTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootTask = mainController.rootTask;
    final myTasksCount = mainController.myUpcomingTasksCount;

    return DashboardWrapper(
      Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          NormalText(loc.my_tasks_title, align: TextAlign.center, color: greyColor),
          Expanded(
            child: myTasksCount > 0 ? Center(child: D1('$myTasksCount', color: mainColor)) : MTImage(ImageNames.empty_tasks.toString()),
          ),
          H3(myTasksCount > 0 ? mainController.myUpcomingTasksTitle : loc.task_list_empty_title, align: TextAlign.center),
          const SizedBox(height: P),
          if (myTasksCount < 1) NormalText(loc.task_list_empty_hint, align: TextAlign.center, height: 1.2),
        ],
      ),
      onTap: () async => await Navigator.of(context).pushNamed(TaskView.routeName, arguments: TaskParams(rootTask.wsId, filters: {TasksFilter.my})),
    );
  }
}
