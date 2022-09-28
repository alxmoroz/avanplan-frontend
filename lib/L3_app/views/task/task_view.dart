// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_ext_actions.dart';
import '../../../L1_domain/entities/task_ext_level.dart';
import '../../../L1_domain/entities/task_ext_state.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/task_level_presenter.dart';
import 'task_related_widgets/task_add_action_widget.dart';
import 'task_related_widgets/task_overview.dart';
import 'task_view_controller.dart';
import 'task_view_widgets/task_details.dart';
import 'task_view_widgets/task_header.dart';
import 'task_view_widgets/task_listview.dart';
import 'task_view_widgets/task_navbar.dart';

class TaskView extends StatelessWidget {
  TaskView(int? taskId) : _controller = TaskViewController(taskId);
  final TaskViewController _controller;

  static String get routeName => 'task_view';
  Task get _task => _controller.task;

  Map<TaskTabKey, Widget> _tabs() {
    final res = <TaskTabKey, Widget>{};
    _controller.tabKeys.forEach((tk) {
      switch (tk) {
        case TaskTabKey.overview:
          res[TaskTabKey.overview] = NormalText(loc.overview);
          break;
        case TaskTabKey.subtasks:
          res[TaskTabKey.subtasks] = NormalText(_task.listTitle);
          break;
        case TaskTabKey.details:
          res[TaskTabKey.details] = NormalText(loc.description);
          break;
      }
    });

    return res;
  }

  Widget _tabPaneSelector() => Padding(
        padding: EdgeInsets.symmetric(horizontal: onePadding),
        child: CupertinoSlidingSegmentedControl<TaskTabKey>(
          children: _tabs(),
          groupValue: _controller.tabKey,
          onValueChanged: _controller.selectTab,
        ),
      );

  Widget get _overviewPane => TaskOverview(_controller);
  Widget get _tasksPane => TaskListView(_controller);
  Widget get _detailsPane => TaskDetails(_controller);

  Widget _selectedPane(BuildContext context) =>
      {
        TaskTabKey.overview: _overviewPane,
        TaskTabKey.subtasks: _tasksPane,
        TaskTabKey.details: _detailsPane,
      }[_controller.tabKey] ??
      _tasksPane;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: _controller.isLoading,
        navBar: taskNavBar(context, _controller),
        body: SafeArea(
          top: !_task.isWorkspace || _controller.hasFilters,
          bottom: false,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (!_task.isWorkspace) TaskHeader(controller: _controller, parentContext: context) else SizedBox(height: onePadding / 2),
              if (_controller.tabKeys.length > 1) ...[
                SizedBox(height: onePadding / 2),
                _tabPaneSelector(),
              ],
              Expanded(child: _selectedPane(context)),
            ],
          ),
        ),
        bottomBar: _task.shouldAddSubtask
            ? TaskAddActionWidget(_controller, parentContext: context)
            : _task.canReopen
                ? MTRoundedButton(
                    topHint: MediumText(_task.isClosable ? loc.task_state_closable_hint : '', align: TextAlign.center, color: lightGreyColor),
                    titleString: _task.isClosable ? loc.task_state_close_btn_title : loc.task_state_reopen_btn_title,
                    leading: _task.isClosable ? doneIcon(context, true) : null,
                    onTap: () => _controller.setClosed(context, !_task.closed),
                  )
                : null,
      ),
    );
  }
}
