// Copyright (c) 2022. Alexandr Moroz

import 'dart:math';

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/colors.dart';
import '../../components/cupertino_page.dart';
import '../../components/details_dialog.dart';
import '../../components/divider.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'tasks_list.dart';

class TaskView extends StatefulWidget {
  static String get routeName => 'task';

  @override
  _TaskViewState createState() => _TaskViewState();
}

class _TaskViewState extends State<TaskView> {
  Widget breadcrumbs(List<Task> parents) {
    String parentsPath = '';
    for (Task pt in parents.take(parents.length - 1)) {
      parentsPath += ' > ' + pt.title;
    }

    return LightText('${mainController.selectedGoal!.title} $parentsPath');
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final Task _task = args['task'];
    final List<Task> _parents = args['parents'];

    final _subTasks = _task.tasks.toList();
    _subTasks.sort((t1, t2) => t1.title.compareTo(t2.title));

    const truncateLength = 100;
    final needTruncate = _task.description.length > truncateLength;

    return MTCupertinoPage(
      navBar: navBar(context, title: '${loc.task_title} #${_task.id}'),
      children: [
        ListTile(
          title: breadcrumbs(_parents),
          subtitle: H2(_task.title),
          dense: true,
          visualDensity: VisualDensity.compact,
        ),
        if (_task.description.isNotEmpty)
          ListTile(
            title: LightText(_task.description.substring(0, min(_task.description.length, truncateLength))),
            subtitle: needTruncate ? const MediumText('...', color: mainColor) : null,
            dense: true,
            visualDensity: VisualDensity.compact,
            onTap: needTruncate ? () => showDetailsDialog(context, _task.description) : null,
          ),
        const MTDivider(),
        if (_task.tasks.isNotEmpty) ...[
          Expanded(child: TasksList(tasks: _subTasks, parents: _parents)),
        ]
      ],
    );
  }
}
