// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/usecases/task_ext_level.dart';
import '../../components/constants.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import '../members/tmr_controller.dart';
import 'panes/task_details.dart';
import 'panes/task_listview.dart';
import 'panes/task_overview.dart';
import 'panes/task_team.dart';
import 'task_view_controller.dart';
import 'widgets/task_header.dart';
import 'widgets/task_navbar.dart';

class TaskView extends StatefulWidget {
  const TaskView(this.taskId);
  final int? taskId;

  static String get routeName => 'task';

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  Task get _task => _controller.task;

  late TaskViewController _controller;
  late TMRController _tmrController;

  late final TaskOverview _overviewPane;
  late final TaskListView _tasksPane;
  late final TaskDetails _detailsPane;
  late final TaskTeam _teamPane;

  @override
  void initState() {
    _controller = TaskViewController(widget.taskId);
    _tmrController = TMRController(_controller.task);

    _overviewPane = TaskOverview(_controller);
    _tasksPane = TaskListView(_controller);
    _detailsPane = TaskDetails(_controller);
    _teamPane = TaskTeam(_tmrController);

    super.initState();
  }

  @override
  void dispose() {
    _tmrController.dispose();
    super.dispose();
  }

  Map<TaskTabKey, Widget> _tabs() {
    final res = <TaskTabKey, Widget>{};
    _controller.tabKeys.forEach((tk) {
      switch (tk) {
        case TaskTabKey.overview:
          res[TaskTabKey.overview] = NormalText(loc.overview);
          break;
        case TaskTabKey.subtasks:
          res[TaskTabKey.subtasks] = NormalText('${_task.listTitle} (${_task.openedSubtasks.length})');
          break;
        case TaskTabKey.details:
          res[TaskTabKey.details] = NormalText(loc.description);
          break;
        case TaskTabKey.team:
          res[TaskTabKey.team] = NormalText(loc.team_title);
          break;
      }
    });

    return res;
  }

  Widget _tabPaneSelector() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P),
        child: CupertinoSlidingSegmentedControl<TaskTabKey>(
          children: _tabs(),
          groupValue: _controller.tabKey,
          onValueChanged: _controller.selectTab,
        ),
      );

  Widget get _selectedPane =>
      {
        TaskTabKey.overview: _overviewPane,
        TaskTabKey.subtasks: _tasksPane,
        TaskTabKey.details: _detailsPane,
        TaskTabKey.team: _teamPane,
      }[_controller.tabKey] ??
      _tasksPane;

  Widget? get _selectedBottomBar => {
        TaskTabKey.overview: _overviewPane.bottomBar,
        TaskTabKey.team: _teamPane.bottomBar,
      }[_controller.tabKey];

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: taskNavBar(context, _controller),
        body: SafeArea(
          top: !_task.isWorkspace,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_task.isWorkspace) TaskHeader(controller: _controller) else const SizedBox(height: P_2),
              if (_controller.tabKeys.length > 1) ...[
                const SizedBox(height: P_2),
                _tabPaneSelector(),
              ],
              Expanded(child: _selectedPane),
            ],
          ),
        ),
        bottomBar: _selectedBottomBar,
      ),
    );
  }
}
