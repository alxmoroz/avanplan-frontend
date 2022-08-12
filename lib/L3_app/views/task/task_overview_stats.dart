// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../../L1_domain/entities/task_stats.dart';
import '../../components/constants.dart';
import '../../components/mt_progress.dart';
import '../../extra/services.dart';
import '../../presenters/number_presenter.dart';
import '../../presenters/task_overview_presenter.dart';

class TaskOverviewStats extends StatelessWidget {
  const TaskOverviewStats(this.task);

  final Task task;

  @override
  Widget build(BuildContext context) {
    final noInfoColor = stateColor(TaskState.noInfo);

    return Column(children: [
      SizedBox(height: onePadding / 2),
      SampleProgress(
        ratio: task.doneRatio,
        color: stateColor(task.state),
        titleText: loc.common_done,
        trailingText: task.doneRatio.inPercents,
      ),
      if (task.hasOverdueTasks) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.overdueTasksCount / task.openedLeafTasksCount,
          color: stateColor(TaskState.overdue),
          titleText: loc.task_filter_overdue,
          trailingText: '${task.overdueTasksCount}',
          subtitleText: overdueStateTextDetails(task.tasksOverduePeriod),
        ),
      ],
      if (task.hasRiskTasks) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.riskyTasksCount / task.openedLeafTasksCount,
          color: stateColor(TaskState.risk),
          titleText: loc.task_filter_risky,
          trailingText: '${task.riskyTasksCount}',
          subtitleText: riskStateTextDetails(task.tasksRiskPeriod),
        ),
      ],
      if (task.hasNoDueGroups) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.noDueGroupsCount / task.openedGroupsCount,
          color: noInfoColor,
          titleText: loc.task_filter_no_due,
          trailingText: '${task.noDueGroupsCount}',
        ),
      ],
      if (task.hasInactiveGroups) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.inactiveGroupsCount / task.openedGroupsCount,
          color: noInfoColor,
          titleText: loc.task_filter_no_progress,
          trailingText: '${task.inactiveGroupsCount}',
        ),
      ],
      if (task.hasClosableGroups) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: task.closableGroupsCount / task.openedGroupsCount,
          color: noInfoColor,
          titleText: loc.task_filter_no_opened_tasks,
          trailingText: '${task.closableGroupsCount}',
        ),
      ],

      // TODO: хотелось бы знать количество запасных дней (если слишком быстро работаем). Но при наличии рисковых задач, то лучше показывать сумму за вычетом отстающих дней.
      // TODO: Подумать, как учитывать суммарное отставание или резерв в днях
    ]);
  }
}
