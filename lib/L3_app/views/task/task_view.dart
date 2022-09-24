// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_actions.dart';
import '../../../L1_domain/entities/task_ext_level.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../main/project_empty_list_actions_widget.dart';
import 'task_related_widgets/task_add_action_widget.dart';
import 'task_related_widgets/task_overview.dart';
import 'task_view_controller.dart';
import 'task_view_widgets/task_details.dart';
import 'task_view_widgets/task_header.dart';
import 'task_view_widgets/task_listview.dart';
import 'task_view_widgets/task_navbar.dart';

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

  Widget get _overviewPane => TaskOverview(controller);
  Widget get _tasksPane => TaskListView(controller);
  Widget get _detailsPane => TaskDetails(controller);

  Widget _selectedPane(BuildContext context) =>
      {
        TaskTabKey.overview: _overviewPane,
        TaskTabKey.subtasks: _tasksPane,
        TaskTabKey.details: _detailsPane,
      }[controller.tabKey] ??
      _tasksPane;

  bool get _showFooter => task.shouldAddSubtask || task.canReopen;

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
            bottom: _showFooter,
            child: !mainController.rootTask.hasOpenedSubtasks
                ? ProjectEmptyListActionsWidget(taskController: controller, parentContext: context)
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (!task.isWorkspace) TaskHeader(controller: controller, parentContext: context) else SizedBox(height: onePadding / 2),
                      if (controller.tabKeys.length > 1) ...[
                        SizedBox(height: onePadding / 2),
                        tabPaneSelector(),
                      ],
                      Expanded(child: _selectedPane(context)),
                      if (task.shouldAddSubtask) TaskAddActionWidget(controller, parentContext: context),
                      if (task.canReopen)
                        MTRichButton(
                          hint: task.isClosable ? loc.task_state_closable_hint : '',
                          titleString: task.isClosable ? loc.task_state_close_btn_title : loc.task_state_reopen_btn_title,
                          prefix: task.isClosable ? doneIcon(context, true) : null,
                          onTap: () => controller.setClosed(context, !task.closed),
                        ),
                      SizedBox(height: onePadding / 2),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
