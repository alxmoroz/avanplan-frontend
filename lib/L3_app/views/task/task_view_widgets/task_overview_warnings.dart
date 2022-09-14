// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../extra/services.dart';
import 'task_card.dart';

class TaskOverviewWarnings extends StatelessWidget {
  const TaskOverviewWarnings(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final warningTasks = <Task>[];
    if (task.hasOverdueTasks) {
      warningTasks.addAll(task.overdueTasks.take(3));
    } else if (task.hasRiskTasks) {
      warningTasks.addAll(task.riskyTasks.take(3));
    }

    return Column(children: [
      ...warningTasks.map((t) => TaskCard(task: t, onTap: () => mainController.showTask(context, t)))
      // TODO: хотелось бы знать количество запасных дней (если слишком быстро работаем). Но при наличии рисковых задач, то лучше показывать сумму за вычетом отстающих дней.
      // TODO: Подумать, как учитывать суммарное отставание или резерв в днях
    ]);
  }
}
