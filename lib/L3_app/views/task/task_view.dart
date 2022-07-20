// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hercules/L3_app/views/task/task_filter_dropdown.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'task_header.dart';
import 'task_listview.dart';
import 'task_overview.dart';
import 'task_view_controller.dart';

class TaskView extends StatelessWidget {
  static String get routeName => 'task_view';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => taskViewController.selectedTask != null ? TaskPage(taskViewController.selectedTask!) : Container(),
    );
  }
}

enum _TabKeys { overview, tasks }

class TaskPage extends StatefulWidget {
  const TaskPage(this.task);

  final Task task;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  _TabKeys? tabKeyValue = _TabKeys.overview;

  Task get task => widget.task;
  bool get hasSubtasks => task.leafTasksCount > 0;
  TaskViewController get _controller => taskViewController;

  Widget tabPaneSelector() => Padding(
        padding: EdgeInsets.symmetric(horizontal: onePadding),
        child: CupertinoSlidingSegmentedControl<_TabKeys>(
          children: {
            _TabKeys.overview: NormalText(loc.overview),
            _TabKeys.tasks: NormalText(loc.task_list_title),
          },
          groupValue: tabKeyValue,
          onValueChanged: (value) => setState(() => tabKeyValue = value),
        ),
      );

  Widget overviewPane() => TaskOverview(task);

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
          title: '${loc.task_title} #${task.id}',
          trailing: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              MTButton.icon(plusIcon(context), () => _controller.addTask(context)),
              SizedBox(width: onePadding * 2),
              MTButton.icon(editIcon(context), () => _controller.editTask(context)),
              SizedBox(width: onePadding),
            ],
          ),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: ListView(
            children: [
              TaskHeader(task),
              if (hasSubtasks) ...[
                SizedBox(height: onePadding / 2),
                tabPaneSelector(),
              ],
              selectedPane(),
              if (!hasSubtasks)
                EmptyDataWidget(
                  title: loc.task_list_empty_title,
                  addTitle: loc.task_title_new,
                  onAdd: () => taskViewController.addTask(context),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
