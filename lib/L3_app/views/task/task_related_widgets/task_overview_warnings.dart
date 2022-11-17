// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../presenters/task_filter_presenter.dart';
import 'task_card.dart';

class TaskOverviewWarnings extends StatelessWidget {
  const TaskOverviewWarnings(this.task);
  final Task task;

  @override
  Widget build(BuildContext context) => Column(children: [for (final wt in task.warningTasks) TaskCard(wt)]);
}
