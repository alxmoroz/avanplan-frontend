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
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'task_card.dart';
import 'task_view_controller.dart';

class TaskView extends StatefulWidget {
  static String get routeName => 'task';

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  TaskViewController get _controller => taskViewController;
  Task? get _task => _controller.task;
  Goal? get _goal => _controller.goal;

  @override
  void initState() {
    _controller.sortTasks();
    super.initState();
  }

  Widget buildBreadcrumbs() {
    const sepStr = '>';
    String parentsPath = '';
    if (_controller.navStackTasks.length > 1) {
      final titles = _controller.navStackTasks.take(_controller.navStackTasks.length - 1).map((pt) => pt.title);
      parentsPath = titles.join(' $sepStr ') + ' $sepStr ';
    }
    return ListTile(
      title: MediumText(_goal!.title),
      subtitle: parentsPath.isNotEmpty ? LightText(parentsPath, padding: EdgeInsets.only(top: onePadding / 2)) : null,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget taskBuilder(BuildContext context, int index) {
    final task = _controller.subtasks[index];
    return TaskCard(task: task, onTapHeader: () => _controller.showTask(context, task));
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    return MTPage(
      navBar: navBar(
        context,
        title: _task != null ? '${loc.task_title} #${_task!.id}' : loc.tasks_title,
        trailing: MTButton.icon(plusIcon(context), () => _controller.addTask(context)),
      ),
      body: Observer(
        builder: (_) => Column(children: [
          SizedBox(height: mq.padding.top + mq.viewPadding.top),
          buildBreadcrumbs(),
          if (_task != null)
            TaskCard(
              task: _task!,
              detailedScreen: true,
              onTapHeader: () => _controller.editTask(context),
            ),
          Expanded(
            child: _controller.subtasks.isEmpty && _controller.isGoal
                ? EmptyDataWidget(
                    title: loc.task_list_empty_title,
                    addTitle: loc.task_title_new,
                    onAdd: () => _controller.addTask(context),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(bottom: mq.padding.bottom + onePadding),
                    itemBuilder: taskBuilder,
                    itemCount: _controller.subtasks.length,
                  ),
          ),
        ]),
      ),
    );
  }
}
