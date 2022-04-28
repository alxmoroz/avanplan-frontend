// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../components/buttons.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/empty_widget.dart';
import '../../components/icons.dart';
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
  TaskViewController get controller => taskViewController;
  Task? get _task => controller.task;
  Goal? get _goal => controller.goal;

  @override
  void initState() {
    controller.sortTasks();
    super.initState();
  }

  Widget buildBreadcrumbs() {
    const sepStr = '>';
    String parentsPath = '';
    if (controller.navStackTasks.length > 1) {
      final titles = controller.navStackTasks.take(controller.navStackTasks.length - 1).map((pt) => pt.title);
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
    final task = controller.subtasks[index];
    return TaskCard(task: task, onTapHeader: () => controller.showTask(context, task));
  }

  @override
  Widget build(BuildContext context) {
    return MTCupertinoPage(
      navBar: navBar(
        context,
        title: _task != null ? '${loc.task_title} #${_task!.id}' : loc.tasks_title,
        trailing: Button.icon(plusIcon(context), () => controller.addTask(context)),
      ),
      body: Observer(
        builder: (_) => Expanded(
          child: Column(children: [
            SizedBox(height: onePadding / 4),
            buildBreadcrumbs(),
            if (_task != null)
              TaskCard(
                task: _task!,
                detailedScreen: true,
                onTapHeader: () => controller.editTask(context),
              ),
            Expanded(
              child: controller.subtasks.isEmpty && controller.isGoal
                  ? EmptyDataWidget(
                      title: loc.task_list_empty_title,
                      addTitle: loc.task_title_new,
                      onAdd: () => controller.addTask(context),
                    )
                  : ListView.builder(
                      itemBuilder: taskBuilder,
                      itemCount: controller.subtasks.length,
                    ),
            ),
          ]),
        ),
      ),
    );
  }
}
