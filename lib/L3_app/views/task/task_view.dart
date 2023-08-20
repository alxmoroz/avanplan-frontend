// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/mt_adaptive.dart';
import '../../components/mt_error_sheet.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_type.dart';
import 'controllers/task_controller.dart';
import 'panes/details_pane.dart';
import 'panes/overview_pane.dart';
import 'panes/tasks_pane.dart';
import 'panes/team/team_pane.dart';
import 'widgets/task_header.dart';
import 'widgets/task_navbar.dart';

class TaskView extends StatefulWidget {
  const TaskView(this.taskIn);
  final Task taskIn;

  static String get routeName => 'task';

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  Task get task => controller.task;

  late final TaskController controller;
  late final OverviewPane overviewPane;
  late final TasksPane tasksPane;
  late final DetailsPane detailsPane;
  late final TeamPane teamPane;

  @override
  void initState() {
    controller = TaskController(widget.taskIn);
    overviewPane = OverviewPane(controller);
    tasksPane = TasksPane(controller);
    detailsPane = DetailsPane(controller);
    teamPane = TeamPane(controller);

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Widget _tab(TaskTabKey tk, Widget icon, Widget title) => GestureDetector(
        onTap: () => controller.selectTab(tk),
        child: controller.tabKey == tk ? title : icon,
      );

  Map<TaskTabKey, Widget> get _tabs {
    final res = <TaskTabKey, Widget>{};
    controller.tabKeys.forEach((tk) {
      switch (tk) {
        case TaskTabKey.overview:
          res[TaskTabKey.overview] = _tab(tk, const EyeIcon(), NormalText(loc.overview));
          break;
        case TaskTabKey.subtasks:
          res[TaskTabKey.subtasks] = _tab(tk, const DoneIcon(true, color: greyTextColor), NormalText('${task.listTitle}'));
          break;
        case TaskTabKey.details:
          res[TaskTabKey.details] = _tab(tk, const RulesIcon(), NormalText(loc.description));
          break;
        case TaskTabKey.team:
          res[TaskTabKey.team] = _tab(tk, const PeopleIcon(), NormalText(loc.team_list_title));
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
    final smallHeight = MediaQuery.of(context).size.height < SCR_XS_HEIGHT;
    return Observer(
      builder: (_) => Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MTPage(
            navBar: taskNavBar(controller),
            body: SafeArea(
              bottom: false,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (!smallHeight) TaskHeader(controller),
                  if (controller.tabKeys.length > 1) _tabPaneSelector,
                  Expanded(child: _selectedPane),
                ],
              ),
            ),
            bottomBar: !smallHeight && _selectedBottomBar != null ? _selectedBottomBar : null,
          ),
          if (task.error != null)
            MTErrorSheet(task.error!, onClose: () {
              task.error = null;
              mainController.refresh();
            }),
        ],
      ),
    );
  }
}
