// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_level.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../components/constants.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../main/project_empty_list_actions_widget.dart';
import 'task_view_controller.dart';
import 'task_view_widgets/task_details_pane.dart';
import 'task_view_widgets/task_header.dart';
import 'task_view_widgets/task_listview.dart';
import 'task_view_widgets/task_navbar.dart';
import 'task_view_widgets/task_overview_pane.dart';

class TaskView extends StatelessWidget {
  TaskView(this.taskId) : controller = TaskViewController(taskId);

  final int? taskId;
  final TaskViewController controller;

  static String get routeName => 'task_view';
  Task get task => controller.task;

  Map<TaskTabKey, Widget> tabs() {
    final res = <TaskTabKey, Widget>{};
    controller.tabKeys.forEach((tk) {
      switch (tk) {
        case TaskTabKey.overview:
          res[TaskTabKey.overview] = NormalText(loc.overview);
          break;
        case TaskTabKey.subtasks:
          res[TaskTabKey.subtasks] = NormalText(task.listTitle);
          break;
        case TaskTabKey.details:
          res[TaskTabKey.details] = NormalText(loc.description);
          break;
      }
    });

    return res;
  }

  Widget tabPaneSelector() => Padding(
        padding: EdgeInsets.symmetric(horizontal: onePadding),
        child: CupertinoSlidingSegmentedControl<TaskTabKey>(
          children: tabs(),
          groupValue: controller.tabKey,
          onValueChanged: controller.selectTab,
        ),
      );

  Widget detailsPane() => TaskDetails(controller);
  Widget selectedPane(BuildContext context) =>
      {
        TaskTabKey.overview: TaskOverview(controller: controller, parentContext: context),
        TaskTabKey.subtasks: TaskListView(controller),
        TaskTabKey.details: detailsPane(),
      }[controller.tabKey] ??
      detailsPane();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: controller.isLoading,
        navBar: taskNavBar(context, controller),
        body: Container(
          alignment: Alignment.center,
          child: SafeArea(
            top: !task.isWorkspace,
            bottom: false,
            child: !mainController.rootTask.hasOpenedSubtasks
                ? ProjectEmptyListActionsWidget(taskController: controller, parentContext: context)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!task.isWorkspace) TaskHeader(task) else SizedBox(height: onePadding / 2),
                      if (controller.tabKeys.length > 1) ...[
                        SizedBox(height: onePadding / 2),
                        tabPaneSelector(),
                      ],
                      Expanded(child: selectedPane(context)),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
