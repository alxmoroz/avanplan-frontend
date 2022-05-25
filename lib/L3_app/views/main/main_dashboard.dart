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
          ratio: ewFilterController.overdueEWCount / ewFilterController.openedEWCount,
          color: stateColor(OverallState.overdue),
          titleText: loc.ew_overdue_items,
          trailingText: '${ewFilterController.overdueEWCount}',
          subtitleText: stateTextDetails(OverallState.overdue, overduePeriod: ewFilterController.overduePeriod),
        ),
      ],

      if (ewFilterController.hasRisk) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.riskyEWCount / ewFilterController.openedEWCount,
          color: stateColor(OverallState.risk),
          titleText: loc.ew_risky_items,
          trailingText: '${ewFilterController.riskyEWCount}',
          subtitleText: stateTextDetails(OverallState.risk, etaRiskPeriod: ewFilterController.riskPeriod),
        ),
      ],

      if (ewFilterController.hasNoDue) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.noDueEWCount / ewFilterController.openedEWCount,
          color: noInfoColor,
          titleText: loc.ew_no_due_items,
          trailingText: '${ewFilterController.noDueEWCount}',
        ),
      ],
      if (ewFilterController.hasInactive) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.inactiveEWCount / ewFilterController.openedEWCount,
          color: noInfoColor,
          titleText: loc.ew_no_progress_items,
          trailingText: '${ewFilterController.inactiveEWCount}',
        ),
      ],
      if (ewFilterController.hasClosable) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.closableEWCount / ewFilterController.openedEWCount,
          color: noInfoColor,
          titleText: loc.ew_no_opened_tasks_items,
          trailingText: '${ewFilterController.closableEWCount}',
        ),
      ],
      // TODO: напрашивается количество запасных дней. Но при наличии рисковых целей, то лучше показывать сумму за вычетом отстающих дней.
      // TODO: Тогда путаница получается... Подумать, как учитывать суммарное отставание или запасы в днях
      if ((ewFilterController.hasOverdue || ewFilterController.hasRisk) && ewFilterController.hasOk) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.okEWCount / ewFilterController.openedEWCount,
          color: stateColor(OverallState.ok),
          titleText: loc.ew_ok_items,
          trailingText: '${ewFilterController.okEWCount}',
        ),
      ],
    ]);
  }
}
