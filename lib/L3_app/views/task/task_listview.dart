// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../extra/services.dart';
import 'task_card.dart';

class TaskListView extends StatelessWidget {
  const TaskListView(this.tasks);
  final Iterable<Task> tasks;

  @override
  Widget build(BuildContext context) {
    Widget cardBuilder(BuildContext context, int index) {
      final element = tasks.elementAt(index);
      // TODO: обработку клика делать внутри карточки
      return TaskCard(
        task: element,
        onTap: () => taskViewController.showTask(context, element),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: cardBuilder,
      itemCount: tasks.length,
    );
  }
}
