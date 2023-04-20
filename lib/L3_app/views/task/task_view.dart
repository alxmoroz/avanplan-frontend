// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../components/constants.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import 'panes/task_details.dart';
import 'panes/task_listview.dart';
import 'panes/task_overview.dart';
import 'panes/task_team.dart';
import 'task_view_controller.dart';
import 'widgets/task_header.dart';
import 'widgets/task_navbar.dart';

class TaskViewArgs {
  TaskViewArgs(this.wsId, this.taskId);
  final int wsId;
  final int? taskId;
}

class TaskView extends StatefulWidget {
  const TaskView(this.args);
  final TaskViewArgs args;

  static String get routeName => 'task';

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  int get wsId => widget.args.wsId;
  int? get taskId => widget.args.taskId;

  Task get task => controller.task;

  late final TaskViewController controller;

  late final TaskOverview _overviewPane;
  late final TaskListView _tasksPane;
  late final TaskDetails _detailsPane;
  late final MemberListView _teamPane;

  @override
  void initState() {
    controller = TaskViewController(wsId, taskId);

    _overviewPane = TaskOverview(controller);
    _tasksPane = TaskListView(controller);
    _detailsPane = TaskDetails(task);
    _teamPane = MemberListView(controller);

    super.initState();
  }

  Map<TaskTabKey, Widget> get _tabs {
    final res = <TaskTabKey, Widget>{};
    controller.tabKeys.forEach((tk) {
      switch (tk) {
        case TaskTabKey.overview:
          res[TaskTabKey.overview] = NormalText(loc.overview);
          break;
        case TaskTabKey.subtasks:
          res[TaskTabKey.subtasks] = NormalText('${task.listTitle} (${task.openedSubtasks.length})');
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
          children: _tabs,
          groupValue: controller.tabKey,
          onValueChanged: controller.selectTab,
        ),
      );

  Widget get _selectedPane =>
      {
        TaskTabKey.overview: _overviewPane,
        TaskTabKey.subtasks: _tasksPane,
        TaskTabKey.details: _detailsPane,
        TaskTabKey.team: _teamPane,
      }[controller.tabKey] ??
      _tasksPane;

  Widget? get _selectedBottomBar => {
        TaskTabKey.overview: _overviewPane.bottomBar,
        // для вкладки Описание показываем тулбар из Обзора, если вкладки обзора нет (это для задач типично). Иначе - родной тулбар
        TaskTabKey.details: controller.tabKeys.contains(TaskTabKey.overview) ? _detailsPane.bottomBar : _overviewPane.bottomBar,
        TaskTabKey.subtasks: _tasksPane.bottomBar,
        TaskTabKey.team: _teamPane.bottomBar,
      }[controller.tabKey];

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: taskNavBar(context, controller),
        body: SafeArea(
          top: !task.isWorkspace,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!task.isWorkspace) TaskHeader(controller) else const SizedBox(height: P_2),
              if (controller.tabKeys.length > 1) ...[
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
