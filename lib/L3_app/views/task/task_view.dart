// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_actions.dart';
import '../../../L1_domain/entities/task_ext_level.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../components/constants.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import 'task_list_empty_widget.dart';
import 'task_view_controller.dart';
import 'task_view_widgets/task_header.dart';
import 'task_view_widgets/task_list_controller.dart';
import 'task_view_widgets/task_listview.dart';
import 'task_view_widgets/task_navbar.dart';
import 'task_view_widgets/task_overview_pane.dart';

enum _TabKeys { overview, tasks }

class TaskView extends StatefulWidget {
  static String get routeName => 'task_view';

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskView> {
  _TabKeys? tabKeyValue;
  TaskViewController get _controller => taskViewController;
  late int taskId;
  Task get task => _controller.taskForId(taskId);
  late TaskListController taskFilterController;

  @override
  void initState() {
    taskId = _controller.selectedTask.id ?? -1;
    tabKeyValue = _TabKeys.overview;
    taskFilterController = TaskListController(taskId);
    super.initState();
  }

  Widget tabPaneSelector() => Padding(
        padding: EdgeInsets.symmetric(horizontal: onePadding),
        child: CupertinoSlidingSegmentedControl<_TabKeys>(
          children: {
            _TabKeys.overview: NormalText(loc.overview),
            _TabKeys.tasks: NormalText(task.listTitle),
          },
          groupValue: tabKeyValue,
          onValueChanged: (value) => setState(() => tabKeyValue = value),
        ),
      );

  Widget tasksPane() => TaskListView(taskFilterController);

  Widget selectedPane() => {_TabKeys.overview: TaskOverview(task), _TabKeys.tasks: tasksPane()}[tabKeyValue] ?? TaskOverview(task);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: taskNavBar(context, task),
        body: SafeArea(
          top: false,
          bottom: false,
          child: (task.isWorkspace && !task.hasSubtasks)
              ? TaskListEmptyWidget(task)
              : ListView(
                  children: [
                    if (task.isWorkspace)
                      tasksPane()
                    else ...[
                      TaskHeader(task),
                      if (task.hasSubtasks) ...[
                        SizedBox(height: onePadding),
                        tabPaneSelector(),
                      ],
                      selectedPane(),
                    ],
                    if (!task.hasSubtasks &&
                        task.canAdd &&
                        [
                          TaskLevel.project,
                          TaskLevel.goal,
                        ].contains(task.level))
                      TaskListEmptyWidget(task),
                  ],
                ),
        ),
      ),
    );
  }
}
