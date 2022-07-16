// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/mt_progress.dart';
import '../../extra/services.dart';
import '../../presenters/task_overview_presenter.dart';

//TODO: вытащить отсюда всё, что можно в EWOverview, либо сделать универсальный виджет для целей и задач из этого

class MainDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noInfoColor = stateColor(OverallState.noInfo);

    return Column(children: [
      if (tasksFilterController.hasOverdue) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: tasksFilterController.overdueTasksCount / tasksFilterController.openedTasksCount,
          color: stateColor(OverallState.overdue),
          titleText: loc.task_filter_overdue,
          trailingText: '${tasksFilterController.overdueTasksCount}',
          subtitleText: stateTextDetails(OverallState.overdue, overduePeriod: tasksFilterController.overduePeriod),
        ),
      ],

      if (tasksFilterController.hasRisk) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: tasksFilterController.riskyTasksCount / tasksFilterController.openedTasksCount,
          color: stateColor(OverallState.risk),
          titleText: loc.task_filter_risky,
          trailingText: '${tasksFilterController.riskyTasksCount}',
          subtitleText: stateTextDetails(OverallState.risk, etaRiskPeriod: tasksFilterController.riskPeriod),
        ),
      ],

      if (tasksFilterController.hasNoDue) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: tasksFilterController.noDueTasksCount / tasksFilterController.openedTasksCount,
          color: noInfoColor,
          titleText: loc.task_filter_no_due,
          trailingText: '${tasksFilterController.noDueTasksCount}',
        ),
      ],
      if (tasksFilterController.hasInactive) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: tasksFilterController.inactiveTasksCount / tasksFilterController.openedTasksCount,
          color: noInfoColor,
          titleText: loc.task_filter_no_progress,
          trailingText: '${tasksFilterController.inactiveTasksCount}',
        ),
      ],
      if (tasksFilterController.hasClosable) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: tasksFilterController.closableTasksCount / tasksFilterController.openedTasksCount,
          color: noInfoColor,
          titleText: loc.task_filter_no_opened_tasks,
          trailingText: '${tasksFilterController.closableTasksCount}',
        ),
      ],
      // TODO: напрашивается количество запасных дней. Но при наличии рисковых целей, то лучше показывать сумму за вычетом отстающих дней.
      // TODO: Тогда путаница получается... Подумать, как учитывать суммарное отставание или запасы в днях
      if ((tasksFilterController.hasOverdue || tasksFilterController.hasRisk) && tasksFilterController.hasOk) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: tasksFilterController.okTasksCount / tasksFilterController.openedTasksCount,
          color: stateColor(OverallState.ok),
          titleText: loc.task_filter_ok,
          trailingText: '${tasksFilterController.okTasksCount}',
        ),
      ],
    ]);
  }
}
