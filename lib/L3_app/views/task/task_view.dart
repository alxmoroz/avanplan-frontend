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
import 'task_add_action_widget.dart';
import 'task_view_controller.dart';
import 'task_view_widgets/task_details_pane.dart';
import 'task_view_widgets/task_header.dart';
import 'task_view_widgets/task_listview.dart';
import 'task_view_widgets/task_navbar.dart';
import 'task_view_widgets/task_overview_pane.dart';

enum _TabKeys { overview, subtasks, details }

class TaskView extends StatefulWidget {
  static String get routeName => 'task_view';

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskView> {
  _TabKeys? tabKeyValue;

  late TaskViewController controller;
  Task get task => controller.task;

  @override
  void initState() {
    controller = TaskViewController();
    tabKeyValue = task.hasSubtasks ? _TabKeys.overview : _TabKeys.details;
    super.initState();
  }

  Widget tabPaneSelector() => Padding(
        padding: EdgeInsets.symmetric(horizontal: onePadding),
        child: CupertinoSlidingSegmentedControl<_TabKeys>(
          children: {
            _TabKeys.overview: NormalText(loc.overview),
            _TabKeys.subtasks: NormalText(task.listTitle),
            _TabKeys.details: NormalText(loc.description),
          },
          groupValue: tabKeyValue,
          onValueChanged: (value) => setState(() => tabKeyValue = value),
        ),
      );

  Widget overviewPane() => TaskOverview(controller);
  Widget tasksPane() => TaskListView(controller);
  Widget detailsPane() => TaskDetails(controller);
  Widget defaultPane() => task.hasSubtasks ? overviewPane() : detailsPane();

  Widget selectedPane() =>
      {
        _TabKeys.overview: overviewPane(),
        _TabKeys.subtasks: tasksPane(),
        _TabKeys.details: detailsPane(),
      }[tabKeyValue] ??
      defaultPane();

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: controller.isLoading,
        navBar: taskNavBar(context, controller),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
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
                TaskAddActionWidget(controller, parentContext: context),
            ],
          ),
        ),
      ),
    );
  }
}
