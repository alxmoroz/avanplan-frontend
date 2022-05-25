// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../components/constants.dart';
import '../../components/mt_progress.dart';
import '../../extra/services.dart';
import '../../presenters/ew_overall_state_presenter.dart';

//TODO: вытащить отсюда всё, что можно в EWDashboard, либо сделать универсальный виджет для целей и задач из этого

class MainDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noInfoColor = stateColor(OverallState.noInfo);

    return Column(children: [
      if (ewFilterController.hasOverdue) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.overdueGoalsCount / ewFilterController.openedGoalsCount,
          color: stateColor(OverallState.overdue),
          titleText: loc.ew_overdue_items,
          trailingText: '${ewFilterController.overdueGoalsCount}',
          subtitleText: stateTextDetails(OverallState.overdue, overduePeriod: ewFilterController.overduePeriod),
        ),
      ],

      if (ewFilterController.hasRisk) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.riskyGoalsCount / ewFilterController.openedGoalsCount,
          color: stateColor(OverallState.risk),
          titleText: loc.ew_risky_items,
          trailingText: '${ewFilterController.riskyGoalsCount}',
          subtitleText: stateTextDetails(OverallState.risk, etaRiskPeriod: ewFilterController.riskPeriod),
        ),
      ],
      //TODO: добавить неосновные статусы для EW
      if (ewFilterController.noDueGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.noDueGoalsCount / ewFilterController.openedGoalsCount,
          color: noInfoColor,
          titleText: loc.ew_no_due_items,
          trailingText: '${ewFilterController.noDueGoalsCount}',
        ),
      ],
      if (ewFilterController.inactiveGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.inactiveGoalsCount / ewFilterController.openedGoalsCount,
          color: noInfoColor,
          titleText: loc.ew_no_progress_items,
          trailingText: '${ewFilterController.inactiveGoalsCount}',
        ),
      ],
      if (ewFilterController.closableGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.closableGoalsCount / ewFilterController.openedGoalsCount,
          color: noInfoColor,
          titleText: loc.ew_no_opened_tasks_items,
          trailingText: '${ewFilterController.closableGoalsCount}',
        ),
      ],
      // TODO: напрашивается количество запасных дней. Но при наличии рисковых целей, то лучше показывать сумму за вычетом отстающих дней.
      // TODO: Тогда путаница получается... Подумать, как учитывать суммарное отставание или запасы в днях
      if ((ewFilterController.hasOverdue || ewFilterController.hasRisk) && ewFilterController.okGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.okGoalsCount / ewFilterController.openedGoalsCount,
          color: stateColor(OverallState.ok),
          titleText: loc.ew_ok_items,
          trailingText: '${ewFilterController.okGoalsCount}',
        ),
      ],
    ]);
  }
}
