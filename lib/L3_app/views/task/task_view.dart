// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'ew_overview.dart';
import 'task_header.dart';
import 'task_listview.dart';
import 'task_view_controller.dart';

class TaskView extends StatelessWidget {
  static String get routeName => 'element_of_work';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => taskViewController.selectedTask != null ? EWPage(taskViewController.selectedTask!) : Container(),
    );
  }
}

enum _TabKeys { overview, tasks }

class EWPage extends StatefulWidget {
  const EWPage(this.ew);

  final Task ew;

  @override
  _EWPageState createState() => _EWPageState();
}

class _EWPageState extends State<EWPage> {
  _TabKeys? tabKeyValue = _TabKeys.overview;

  Task get ew => widget.ew;
  bool get hasSubtasks => ew.leafTasksCount > 0;
  TaskViewController get _controller => taskViewController;

  Widget tabPaneSelector() => Padding(
        padding: EdgeInsets.symmetric(horizontal: onePadding),
        child: CupertinoSlidingSegmentedControl<_TabKeys>(
          children: {
            _TabKeys.overview: NormalText(loc.overview),
            _TabKeys.tasks: NormalText(loc.tasks_title),
          },
          groupValue: tabKeyValue,
          onValueChanged: (value) => setState(() => tabKeyValue = value),
        ),
      );

  Widget overviewPane() => EWOverview(ew);

  Widget tasksPane() => Column(
        children: [
          SizedBox(height: onePadding / 2),
          TaskListView(taskViewController.subtasks),
          SizedBox(height: onePadding),
        ],
      );

  Widget selectedPane() => {_TabKeys.overview: overviewPane(), _TabKeys.tasks: tasksPane()}[tabKeyValue] ?? overviewPane();

  @override
  Widget build(BuildContext context) {
    return MTPage(
      isLoading: _controller.isLoading,
      navBar: navBar(
        context,
        title: '${ew.isRoot ? loc.goal_title : loc.task_title} #${ew.id}',
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
            TaskHeader(ew),
            if (hasSubtasks) ...[
              SizedBox(height: onePadding / 2),
              tabPaneSelector(),
            ],
            selectedPane(),
            if (!hasSubtasks && ew.isRoot)
              EmptyDataWidget(
                title: loc.task_list_empty_title,
                addTitle: loc.task_title_new,
                onAdd: () => taskViewController.addTask(context),
              ),
          ],
        ),
      ),
    );
  }
}
