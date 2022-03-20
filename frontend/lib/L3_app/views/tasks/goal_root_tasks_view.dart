// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/cupertino_page.dart';
import '../../components/divider.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'tasks_list.dart';

class GoalRootTasksView extends StatefulWidget {
  static String get routeName => 'goal_root_tasks';

  @override
  _GoalRootTasksViewState createState() => _GoalRootTasksViewState();
}

class _GoalRootTasksViewState extends State<GoalRootTasksView> {
  Goal? get _goal => mainController.selectedGoal;

  @override
  Widget build(BuildContext context) {
    final _rootTasks = _goal!.tasks.where((t) => t.parentId == null).toList();
    _rootTasks.sort((t1, t2) => t1.title.compareTo(t2.title));

    return MTCupertinoPage(
      navBar: navBar(context, title: loc.tasks_title),
      children: [
        ListTile(
          title: H2(_goal!.title),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        const MTDivider(),
        Expanded(child: TasksList(tasks: _rootTasks)),
      ],
    );
  }
}
