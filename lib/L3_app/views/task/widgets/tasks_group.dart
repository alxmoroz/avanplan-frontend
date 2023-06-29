// Copyright (c) 2023. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../extra/services.dart';
import 'task_card.dart';

// TODO: добавить опциональный заголовок для группы

class TasksGroup extends StatelessWidget {
  const TasksGroup(
    this.tasks, {
    this.isMine = false,
    this.groupBorder = false,
    this.standalone = true,
  });

  final List<Task> tasks;
  final bool isMine;
  final bool groupBorder;
  final bool standalone;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: standalone ? null : const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (BuildContext _, int index) {
        final t = tasks[index];
        return TaskCard(
          mainController.taskForId(t.wsId, t.id),
          showStateMark: true,
          bottomBorder: index < tasks.length - 1 || groupBorder,
          isMine: isMine,
          showParent: isMine,
        );
      },
    );
  }
}
