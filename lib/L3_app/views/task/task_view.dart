// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/usecases/task_ext_actions.dart';
import '../../../L1_domain/usecases/task_ext_level.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import 'task_related_widgets/task_add_button.dart';
import 'task_view_controller.dart';
import 'task_view_widgets/task_details.dart';
import 'task_view_widgets/task_header.dart';
import 'task_view_widgets/task_listview.dart';
import 'task_view_widgets/task_navbar.dart';
import 'task_view_widgets/task_overview.dart';

class TaskView extends StatefulWidget {
  const TaskView(this.taskId);
  final int? taskId;

  static String get routeName => 'task_view';

  @override
  State<TaskView> createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  late TaskViewController _controller;
  Task get _task => _controller.task;

  @override
  void initState() {
    _controller = TaskViewController(widget.taskId);
    super.initState();
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

  Widget _selectedPane(BuildContext context) {
    final _overviewPane = TaskOverview(_controller.task);
    final _tasksPane = TaskListView(_controller);
    final _detailsPane = TaskDetails(_controller);
    return {
          TaskTabKey.overview: _overviewPane,
          TaskTabKey.subtasks: _tasksPane,
          TaskTabKey.details: _detailsPane,
        }[_controller.tabKey] ??
        _tasksPane;
  }

  Widget? _bottomBar(BuildContext context) => _task.isWorkspace && _task.actionTypes.isNotEmpty && mainController.canEditAnyWS
      ? Row(children: [const Spacer(), TaskAddMenu(_controller)])
      : _controller.canEditTask
          ? _task.shouldAddSubtask
              ? TaskAddButton(_controller)
              : _task.canReopen || _task.shouldClose || _task.shouldCloseLeaf
                  ? Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                      if (_task.shouldClose)
                        MediumText(
                          loc.state_closable_hint,
                          align: TextAlign.center,
                          color: lightGreyColor,
                          padding: const EdgeInsets.only(bottom: P_3),
                        ),
                      MTButton.outlined(
                        margin: const EdgeInsets.symmetric(horizontal: P),
                        titleText: (_task.shouldClose || _task.shouldCloseLeaf) ? loc.close_action_title : loc.task_reopen_action_title,
                        leading: DoneIcon(_task.shouldClose || _task.shouldCloseLeaf),
                        onTap: () => _controller.setClosed(context, !_task.closed),
                      ),
                    ])
                  : null
          : null;

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
              Expanded(child: _selectedPane(context)),
            ],
          ),
        ),
        bottomBar: _bottomBar(context),
      ),
    );
  }
}
