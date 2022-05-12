// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../components/constants.dart';
import '../../components/empty_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import 'task_card.dart';
import 'task_view_controller.dart';

class TaskView extends StatelessWidget {
  static String get routeName => 'task';

  TaskViewController get _controller => taskViewController;
  Task? get _task => _controller.task;
  Goal? get _goal => _controller.goal;

  String breadcrumbs() {
    const sepStr = ' ⟩ ';
    String _breadcrumbs = '';
    if (_controller.navStackTasks.length > 1) {
      final titles = _controller.navStackTasks.take(_controller.navStackTasks.length - 1).map((pt) => pt.title).toList();
      titles.insert(0, _goal!.title);
      _breadcrumbs = titles.join(sepStr);
    }
    return _breadcrumbs;
  }

  Widget taskBuilder(BuildContext context, int index) {
    Widget element = SizedBox(height: onePadding);
    if (index == 0 && _task != null) {
      element = TaskCard(
        task: _task!,
        showDetails: true,
        breadcrumbs: breadcrumbs(),
        onTapHeader: () => _controller.editTask(context),
      );
    } else if (index > 0 && index < _controller.subtasks.length + 1) {
      final task = _controller.subtasks[index - 1];
      element = TaskCard(task: task, onTapHeader: () => _controller.showTask(context, task));
    }
    return element;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        navBar: navBar(
          context,
          title: _task != null ? '${loc.task_title} #${_task!.id}' : '${loc.tasks_title} - ${_goal!.title}',
          trailing: MTButton.icon(plusIcon(context), () => _controller.addTask(context)),
        ),
        body: SafeArea(
          top: false,
          bottom: false,
          child: _controller.subtasks.isEmpty && _controller.isGoal
              ? EmptyDataWidget(
                  title: loc.task_list_empty_title,
                  addTitle: loc.task_title_new,
                  onAdd: () => _controller.addTask(context),
                )
              : ListView.builder(
                  itemBuilder: taskBuilder,
                  itemCount: _controller.subtasks.length + 2,
                ),
        ),
      ),
    );
  }
}
