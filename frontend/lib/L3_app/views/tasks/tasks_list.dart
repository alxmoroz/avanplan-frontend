// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/task.dart';
import '../../components/divider.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import 'task_view.dart';

class TasksList extends StatelessWidget {
  const TasksList({
    required this.tasks,
    this.parents,
  });

  final List<Task> tasks;
  final List<Task>? parents;

  Future goToTaskView(BuildContext context, Task task) async {
    final List<Task> _parents = parents ?? [];
    _parents.add(task);

    await Navigator.of(context).pushNamed(TaskView.routeName, arguments: {'task': task, 'parents': _parents});
    // TODO: нужен контроллер и стейт, сбрасываемый при поднимании на уровень выше
    _parents.remove(task);
  }

  Widget taskBuilder(BuildContext context, int index) {
    final task = tasks.elementAt(index);
    return Column(
      children: [
        if (index > 0) const MTDivider(),
        ListTile(
          title: NormalText(task.title),
          trailing: chevronIcon(context),
          dense: true,
          visualDensity: VisualDensity.compact,
          onTap: () => goToTaskView(context, task),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: taskBuilder,
      itemCount: tasks.length,
    );
  }
}
