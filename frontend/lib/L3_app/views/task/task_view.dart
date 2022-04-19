// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../components/buttons.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/divider.dart';
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
  Task? get task => controller.task;
  Goal? get goal => controller.goal;

  @override
  void initState() {
    controller.sortTasks();
    super.initState();
  }

  Widget buildBreadcrumbs() {
    const sepStr = '>';
    String parentsPath = '';
    if (controller.navStackTasks.isNotEmpty) {
      final titles = controller.navStackTasks.take(controller.navStackTasks.length - 1).map((pt) => pt.title);
      parentsPath = titles.join(' $sepStr ');
    }
    return ListTile(
      title: controller.isGoal ? MediumText(goal!.title) : LightText('${goal!.title}', maxLines: 1),
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
        title: task != null ? '${loc.task_title} #${task!.id}' : loc.tasks_title,
        trailing: Button.icon(plusIcon(context), () => controller.addTask(context)),
      ),
      body: Observer(
        builder: (_) => Expanded(
          child: Column(
            children: [
              SizedBox(height: onePadding),
              buildBreadcrumbs(),
              if (task != null)
                TaskCard(
                  task: task!,
                  detailedScreen: true,
                  onTapHeader: () => controller.editTask(context),
                ),
              if (controller.subtasks.isNotEmpty) const MTDivider(),
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
            ],
          ),
        ),
      ),
    );
  }
}
