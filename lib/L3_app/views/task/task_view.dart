// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities_extensions/task_tree.dart';
import '../../components/adaptive.dart';
import '../../components/colors_base.dart';
import '../../components/constants.dart';
import '../../components/error_sheet.dart';
import '../../components/icons.dart';
import '../../components/icons_workspace.dart';
import '../../components/page.dart';
import '../../components/text.dart';
import '../../extra/router.dart';
import '../../extra/services.dart';
import '../../presenters/task_type.dart';
import 'controllers/task_controller.dart';
import 'widgets/details/details_pane.dart';
import 'widgets/empty_state/not_found.dart';
import 'widgets/header/task_header.dart';
import 'widgets/header/task_navbar.dart';
import 'widgets/overview/overview_pane.dart';
import 'widgets/tasks/tasks_pane.dart';
import 'widgets/team/team_pane.dart';

class TaskRouter extends MTRouter {
  static const _prefix = '/projects.*?';

  @override
  RegExp get pathRe => RegExp('^$_prefix/(\\d+)/(\\d+)\$');
  int get _wsId => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(1) ?? '-1');
  int get _taskId => int.parse(pathRe.firstMatch(rs!.uri.path)?.group(2) ?? '-1');
  Task? get _task => tasksMainController.task(_wsId, _taskId);

  // TODO: костыль
  @override
  Widget? get page => rs!.arguments != null
      ? TaskView(rs!.arguments as TaskController)
      : Observer(
          builder: (ctx) => loader.loading
              ? Container()
              : _task != null
                  ? TaskView(TaskController(_task!))
                  : NotFoundPage(),
        );

  @override
  String get title => (rs!.arguments as TaskController?)?.task.viewTitle ?? '';
  String _navPrefix(Task task) => task.isProject
      ? '/projects'
      : task.isGoal
          ? '/projects/goals'
          : task.isBacklog
              ? '/projects/backlogs'
              : '/projects/tasks';

  String _navPath(Task _task) => '${_navPrefix(_task)}/${_task.wsId}/${_task.id}';
  @override
  Future navigate(BuildContext context, {Object? args}) async => await Navigator.of(context).pushNamed(
        _navPath((args as TaskController).task),
        arguments: args,
      );
}

class TaskView extends StatefulWidget {
  // TODO: отвязаться от создания контроллера заранее. Создавать контроллер (инициализировать FData) нужно после загрузки данных,
  //  либо делать реиницилаизацию после загрузки данных.
  //  Кроме того, нужно отправлять сюда только айдишники
  const TaskView(this._controller);
  final TaskController _controller;

  @override
  State<TaskView> createState() => TaskViewState();
}

class TaskViewState<T extends TaskView> extends State<T> {
  TaskController get controller => widget._controller;
  Task get task => controller.task;

  late OverviewPane overviewPane;
  late final TasksPane tasksPane;
  late final DetailsPane detailsPane;
  late final TeamPane teamPane;

  @override
  void initState() {
    if (kIsWeb) {
      setWebpageTitle(task.viewTitle);
    }

    overviewPane = OverviewPane(controller);
    tasksPane = TasksPane(controller);
    detailsPane = DetailsPane(controller);
    teamPane = TeamPane(controller);

    super.initState();
  }

  @override
  void dispose() {
    if (controller.allowDisposeFromView) {
      controller.dispose();
    }
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
          res[TaskTabKey.overview] = _tab(tk, const OverviewIcon(), BaseText(loc.overview));
          break;
        case TaskTabKey.subtasks:
          res[TaskTabKey.subtasks] = _tab(tk, const TasksIcon(), BaseText('${task.listTitle}'));
          break;
        case TaskTabKey.details:
          res[TaskTabKey.details] = _tab(tk, const RulesIcon(size: P4, color: f2Color), BaseText(loc.details));
          break;
        case TaskTabKey.team:
          res[TaskTabKey.team] = _tab(tk, const PeopleIcon(color: f2Color), BaseText(loc.team_title));
          break;
      }
    });

    return res;
  }

  Widget get _tabPaneSelector => MTAdaptive(
        force: true,
        padding: const EdgeInsets.symmetric(horizontal: P3),
        child: CupertinoSlidingSegmentedControl<TaskTabKey>(
          children: _tabs,
          groupValue: controller.tabKey,
          onValueChanged: controller.selectTab,
          backgroundColor: b1Color,
          thumbColor: b3Color,
        ),
      );

  Widget get _selectedPane =>
      {
        TaskTabKey.overview: overviewPane,
        TaskTabKey.subtasks: tasksPane,
        TaskTabKey.team: teamPane,
        TaskTabKey.details: detailsPane,
      }[controller.tabKey] ??
      detailsPane;

  Widget? get _selectedBottomBar => {
        TaskTabKey.overview: overviewPane.bottomBar,
        TaskTabKey.subtasks: tasksPane.bottomBar,
        TaskTabKey.team: teamPane.bottomBar,
        TaskTabKey.details: detailsPane.bottomBar,
      }[controller.tabKey];

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      final smallHeight = MediaQuery.sizeOf(context).height < SCR_XS_HEIGHT;
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          MTPage(
            appBar: taskAppBar(context, controller),
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
              tasksMainController.refreshTasks();
            }),
        ],
      );
    });
  }
}
