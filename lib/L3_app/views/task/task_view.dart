// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../../presenters/task_stats_presenter.dart';
import '../task/task_filter_dropdown.dart';
import 'task_add_action.dart';
import 'task_header.dart';
import 'task_listview.dart';
import 'task_overview_pane.dart';
import 'task_view_controller.dart';

enum _TabKeys { overview, tasks }

class TaskView extends StatefulWidget {
  static String get routeName => 'task_view';

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskView> {
  _TabKeys? tabKeyValue = _TabKeys.overview;

  TaskViewController get _controller => taskViewController;
  Task get task => _controller.selectedTask;

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

  Widget overviewPane() => TaskOverview();

  Widget tasksPane() => Column(
        children: [
          if (tasksFilterController.hasFilters) ...[
            SizedBox(height: onePadding),
            TaskFilterDropdown(),
          ],
          SizedBox(height: onePadding / 2),
          TaskListView(tasksFilterController.filteredTasks),
          SizedBox(height: onePadding),
        ],
      );

  Widget selectedPane() => {_TabKeys.overview: overviewPane(), _TabKeys.tasks: tasksPane()}[tabKeyValue] ?? overviewPane();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: navBar(
          context,
          title: _controller.isWorkspace ? loc.project_list_title : task.viewTitle,
          leading: _controller.canRefresh
              ? Row(children: [
                  SizedBox(width: onePadding),
                  MTButton.icon(refreshIcon(context), mainController.updateAll),
                ])
              : null,
          trailing: Row(mainAxisAlignment: MainAxisAlignment.end, mainAxisSize: MainAxisSize.min, children: [
            if (_controller.canImport) ...[
              MTButton.icon(importIcon(context), () => importController.importTasks(context)),
              SizedBox(width: onePadding),
            ],
            if (_controller.canAdd) ...[
              MTButton.icon(plusIcon(context), () => _controller.addTask(context)),
              SizedBox(width: onePadding),
            ],
            if (_controller.canEdit) ...[
              MTButton.icon(editIcon(context), () => _controller.editTask(context)),
              SizedBox(width: onePadding),
            ],
            if (_controller.selectedTask.hasLink) ...[
              MTButton.icon(unlinkIcon(context), () => _controller.unlink(context)),
              SizedBox(width: onePadding),
            ],
          ]),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: (_controller.isWorkspace && !task.hasSubtasks)
              ? TaskAddAction(task)
              : ListView(
                  children: [
                    if (_controller.isWorkspace)
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
                        _controller.canAdd &&
                        [
                          TaskLevel.project,
                          TaskLevel.goal,
                        ].contains(task.level))
                      TaskAddAction(task),
                  ],
                ),
        ),
      ),
    );
  }
}
