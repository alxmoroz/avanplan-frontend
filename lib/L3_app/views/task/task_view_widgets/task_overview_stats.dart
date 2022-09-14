// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../../L1_domain/entities/task.dart';
import '../../../../L1_domain/entities/task_ext_state.dart';
import '../../../components/constants.dart';
import '../../../components/mt_progress.dart';
import '../../../extra/services.dart';
import '../../../presenters/task_overview_presenter.dart';

class TaskOverviewStats extends StatelessWidget {
  const TaskOverviewStats(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if (task.hasOverdueTasks) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.overdueTasksCount / task.openedLeafTasksCount,
          color: task.overdueColor,
          titleText: task.overDueDetails,
          trailingText: '${task.overdueTasksCount}',
        ),
      ],
      if (task.hasRiskTasks) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.riskyTasksCount / task.openedLeafTasksCount,
          color: task.riskColor,
          titleText: task.riskyDetails,
          trailingText: '${task.riskyTasksCount}',
        ),
      ],
      if (task.hasNoDueGoals) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.noDueGoalsCount / task.openedGoalsCount,
          titleText: loc.task_state_no_due_details,
          trailingText: '${task.noDueGoalsCount}',
        ),
      ],
      if (task.hasEmptyGoals) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.emptyGoalsCount / task.openedGoalsCount,
          titleText: loc.task_state_no_tasks_goal_details,
          trailingText: '${task.emptyGoalsCount}',
        ),
      ],
      if (task.hasInactiveGoals) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.inactiveGoalsCount / task.openedGoalsCount,
          titleText: loc.task_state_no_progress_details,
          trailingText: '${task.inactiveGoalsCount}',
        ),
      ],
      if (task.hasClosableGroups) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.closableGroupsCount / task.openedGoalsCount,
          titleText: loc.task_state_closable_title,
          trailingText: '${task.closableGroupsCount}',
        ),
      ],

      // TODO: хотелось бы знать количество запасных дней (если слишком быстро работаем). Но при наличии рисковых задач, то лучше показывать сумму за вычетом отстающих дней.
      // TODO: Подумать, как учитывать суммарное отставание или резерв в днях
    ]);
  }
}
