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
import 'panes/details_pane.dart';
import 'panes/overview_pane.dart';
import 'panes/tasks/tasks_pane.dart';
import 'panes/tasks/tasks_pane_controller.dart';
import 'panes/team/team_pane.dart';
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

  late final OverviewPane overviewPane;
  late final TasksPane tasksPane;
  late final DetailsPane detailsPane;
  late final TeamPane teamPane;

  @override
  void initState() {
    controller = TaskViewController(wsId, taskId);
    overviewPane = OverviewPane(controller);
    tasksPane = TasksPane(controller, TasksPaneController(task));
    detailsPane = DetailsPane(task);
    teamPane = TeamPane(controller);

    super.initState();
  }

  Map<TaskTabKey, Widget> get tabs {
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

  Widget get tabPaneSelector => Padding(
        padding: const EdgeInsets.symmetric(horizontal: P),
        child: CupertinoSlidingSegmentedControl<TaskTabKey>(
          children: tabs,
          groupValue: controller.tabKey,
          onValueChanged: controller.selectTab,
        ),
      );

  Widget get selectedPane =>
      {
        TaskTabKey.overview: overviewPane,
        TaskTabKey.subtasks: tasksPane,
        TaskTabKey.details: detailsPane,
        TaskTabKey.team: teamPane,
      }[controller.tabKey] ??
      tasksPane;

  Widget? get selectedBottomBar => {
        TaskTabKey.overview: overviewPane.bottomBar,
        // для вкладки Описание показываем тулбар из Обзора, если вкладки обзора нет (это для задач типично). Иначе - родной тулбар
        TaskTabKey.details: controller.tabKeys.contains(TaskTabKey.overview) ? detailsPane.bottomBar : overviewPane.bottomBar,
        TaskTabKey.subtasks: tasksPane.bottomBar,
        TaskTabKey.team: teamPane.bottomBar,
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
              if (controller.tabKeys.length > 1) ...[
                const SizedBox(height: P_2),
                tabPaneSelector,
              ],
              Expanded(child: selectedPane),
            ],
          ),
        ),
        bottomBar: !smallHeight && selectedBottomBar != null ? Padding(padding: const EdgeInsets.only(bottom: P), child: selectedBottomBar) : null,
      ),
    );
  }
}
