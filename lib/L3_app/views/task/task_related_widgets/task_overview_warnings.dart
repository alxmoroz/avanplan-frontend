// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/usecases/task_ext_state.dart';
import 'task_card.dart';

class TaskOverviewWarnings extends StatelessWidget {
  const TaskOverviewWarnings(this.task);
  final Task task;

  Iterable<Task> get warningTasks {
    final res = <Task>[];
    if (task.overdueSubtasks.isNotEmpty) {
      res.addAll(task.overdueSubtasks.take(3));
    } else if (task.riskySubtasks.isNotEmpty) {
      res.addAll(task.riskySubtasks.take(3));
    }
    return res;
  }

  // TODO: хотелось бы знать количество запасных дней (если слишком быстро работаем). Но при наличии рисковых задач, то лучше показывать сумму за вычетом отстающих дней.
  // TODO: Подумать, как учитывать суммарное отставание или резерв в днях

  @override
  Widget build(BuildContext context) => Column(children: [...warningTasks.map((wt) => TaskCard(wt))]);
}
