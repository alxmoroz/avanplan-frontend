// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_level.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/mt_adaptive.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import 'panes/details_pane.dart';
import 'panes/overview_pane.dart';
import 'panes/tasks/tasks_pane.dart';
import 'panes/tasks/tasks_pane_controller.dart';
import 'panes/team/team_pane.dart';
import 'task_view_controller.dart';
import 'widgets/task_header.dart';
import 'widgets/task_navbar.dart';

class TaskView extends StatefulWidget {
  const TaskView(this.tp);
  final TaskParams tp;

  static String get routeName => 'task';

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  Task get task => controller.task;

  late final TaskViewController controller;
  late final OverviewPane overviewPane;
  late final TasksPane tasksPane;
  late final DetailsPane detailsPane;
  late final TeamPane teamPane;

  @override
  void initState() {
    controller = TaskViewController(widget.tp);
    overviewPane = OverviewPane(controller);
    tasksPane = TasksPane(controller, TasksPaneController(controller));
    detailsPane = DetailsPane(controller);
    teamPane = TeamPane(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _tab(bool selected, Widget icon, Widget title) => selected ? title : icon;

  Map<TaskTabKey, Widget> get _tabs {
    final res = <TaskTabKey, Widget>{};
    controller.tabKeys.forEach((tk) {
      final selected = controller.tabKey == tk;
      switch (tk) {
        case TaskTabKey.overview:
          res[TaskTabKey.overview] = _tab(selected, const EyeIcon(), NormalText(loc.overview));
          break;
        case TaskTabKey.subtasks:
          res[TaskTabKey.subtasks] = _tab(selected, const DoneIcon(true, color: greyColor), NormalText('${task.listTitle}'));
          break;
        case TaskTabKey.details:
          res[TaskTabKey.details] = _tab(selected, const RulesIcon(), NormalText(loc.description));
          break;
        case TaskTabKey.team:
          res[TaskTabKey.team] = _tab(selected, const PeopleIcon(), NormalText(loc.team_list_title));
          break;
      }
    });

    return res;
  }

  Widget get _tabPaneSelector => MTAdaptive(
        force: true,
        padding: const EdgeInsets.symmetric(horizontal: P),
        child: CupertinoSlidingSegmentedControl<TaskTabKey>(
          children: _tabs,
          groupValue: controller.tabKey,
          onValueChanged: controller.selectTab,
        ),
      );

  Widget get _selectedPane =>
      {
        TaskTabKey.overview: overviewPane,
        TaskTabKey.subtasks: tasksPane,
        TaskTabKey.team: teamPane,
        TaskTabKey.details: detailsPane,
      }[controller.tabKey] ??
      tasksPane;

  Widget? get _selectedBottomBar => {
        TaskTabKey.overview: overviewPane.bottomBar,
        TaskTabKey.subtasks: tasksPane.bottomBar,
        TaskTabKey.team: teamPane.bottomBar,
        TaskTabKey.details: detailsPane.bottomBar,
      }[controller.tabKey];

  @override
  Widget build(BuildContext context) {
    final smallHeight = MediaQuery.of(context).size.height < SCR_S_HEIGHT;
    return Observer(
      builder: (_) => MTPage(
        navBar: taskNavBar(controller),
        body: SafeArea(
          top: !task.isRoot,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!smallHeight && !task.isRoot) TaskHeader(controller),
              if (controller.tabKeys.length > 1) _tabPaneSelector,
              Expanded(child: _selectedPane),
            ],
          ),
        ),
        bottomBar: !smallHeight && _selectedBottomBar != null ? _selectedBottomBar : null,
      ),
    );
  }
}
