// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../../L1_domain/entities/goals/task.dart';
import '../../components/buttons.dart';
import '../../components/colors.dart';
import '../../components/cupertino_page.dart';
import '../../components/date_string_widget.dart';
import '../../components/details_dialog.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'task_view_controller.dart';

class TaskView extends StatefulWidget {
  static String get routeName => 'task';

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  TaskViewController get _controller => taskViewController;
  Task? get _task => _controller.selectedTask;
  Goal? get _goal => mainController.selectedGoal;

  @override
  void initState() {
    _controller.initState();
    super.initState();
  }

  Widget buildBreadcrumbs() {
    String parentsPath = '';
    if (_controller.navStackTasks.isNotEmpty) {
      final titles = _controller.navStackTasks.take(_controller.navStackTasks.length - 1).map((pt) => pt.title);
      parentsPath = titles.join(' > ');
    }
    return ListTile(
      title: MediumText(_goal!.title),
      subtitle: parentsPath.isNotEmpty ? LightText(parentsPath) : null,
      dense: true,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget buildTitle() {
    return !_controller.isRootTask
        ? ListTile(
            title: H2(_task!.title),
            trailing: editIcon(context),
            onTap: () => _controller.editTask(context),
            dense: true,
            visualDensity: VisualDensity.compact,
          )
        : Container();
  }

  Widget buildDescription() {
    final description = _task?.description ?? '';
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
    return ListTile(
      title: Row(
        children: [
          DateStringWidget(_task?.dueDate, titleString: loc.common_due_date_label),
        ],
      ),
    );
  }

  Widget taskBuilder(BuildContext context, int index) {
    final task = _controller.subtasks[index];
    return Column(
      children: [
        if (index > 0) const MTDivider(),
        ListTile(
          title: NormalText(task.title),
          trailing: chevronIcon(context),
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () => _controller.showTask(context, task),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MTCupertinoPage(
      navBar: navBar(
        context,
        title: _task != null ? '${loc.task_title} #${_task!.id}' : loc.tasks_title,
        trailing: Button.icon(plusIcon(context), () => _controller.addTask(context)),
      ),
      body: Observer(
        builder: (_) => Expanded(
          child: Column(
            children: [
              buildBreadcrumbs(),
              buildTitle(),
              buildDescription(),
              buildDates(),
              const MTDivider(),
              if (_controller.subtasks.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemBuilder: taskBuilder,
                    itemCount: _controller.subtasks.length,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
