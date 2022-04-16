// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/date_string_widget.dart';
import '../../components/details_dialog.dart';
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

  Widget buildTitle() {
    return !controller.isGoal
        ? ListTile(
            title: task?.status != null ? SmallText(task?.status?.title ?? '-') : null,
            subtitle: H2(task?.title ?? ''),
            trailing: editIcon(context),
            onTap: () => controller.editTask(context),
            dense: true,
            visualDensity: VisualDensity.compact,
          )
        : Container();
  }

  Widget buildDescription() {
    final description = task?.description ?? '';
    if (description.isNotEmpty) {
      const truncateLength = 100;
      final needTruncate = description.length > truncateLength;

      return ListTile(
        title: LightText(description.substring(0, min(description.length, truncateLength))),
        subtitle: needTruncate ? const MediumText('...', color: mainColor) : null,
        dense: true,
        visualDensity: VisualDensity.compact,
        onTap: needTruncate ? () => showDetailsDialog(context, description) : null,
      );
    } else {
      return Container();
    }
  }

  Widget buildDates() {
    return task?.dueDate != null
        ? ListTile(
            title: Row(
              children: [
                DateStringWidget(task?.dueDate, titleString: loc.common_due_date_label),
              ],
            ),
          )
        : Container();
  }

  Widget taskBuilder(BuildContext context, int index) {
    final task = controller.subtasks[index];
    return TaskCard(
      task: task,
      onTap: () => controller.showTask(context, task),
    );
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
              buildTitle(),
              buildDescription(),
              buildDates(),
              const MTDivider(),
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
