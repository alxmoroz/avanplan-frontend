// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../presenters/task_filter_presenter.dart';
import 'task_card.dart';

class AttentionalTasks extends StatelessWidget {
  const AttentionalTasks(this.task);
  final Task task;

  @override
  Widget build(BuildContext context) {
    final tasks = task.attentionalTasks;
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (BuildContext _, int index) {
        final t = tasks[index];
        return TaskCard(t, bottomBorder: index < tasks.length - 1);
      },
    );
  }
}
