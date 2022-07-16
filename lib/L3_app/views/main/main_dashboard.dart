// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/task.dart';
import '../../components/constants.dart';
import '../../components/mt_progress.dart';
import '../../extra/services.dart';
import '../../presenters/ew_overview_presenter.dart';

//TODO: вытащить отсюда всё, что можно в EWOverview, либо сделать универсальный виджет для целей и задач из этого

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
          titleText: loc.ew_filter_overdue,
          trailingText: '${ewFilterController.overdueEWCount}',
          subtitleText: stateTextDetails(OverallState.overdue, overduePeriod: ewFilterController.overduePeriod),
        ),
      ],

      if (ewFilterController.hasRisk) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.riskyEWCount / ewFilterController.openedEWCount,
          color: stateColor(OverallState.risk),
          titleText: loc.ew_filter_risky,
          trailingText: '${ewFilterController.riskyEWCount}',
          subtitleText: stateTextDetails(OverallState.risk, etaRiskPeriod: ewFilterController.riskPeriod),
        ),
      ],

      if (ewFilterController.hasNoDue) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.noDueEWCount / ewFilterController.openedEWCount,
          color: noInfoColor,
          titleText: loc.ew_filter_no_due,
          trailingText: '${ewFilterController.noDueEWCount}',
        ),
      ],
      if (ewFilterController.hasInactive) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.inactiveEWCount / ewFilterController.openedEWCount,
          color: noInfoColor,
          titleText: loc.ew_filter_no_progress,
          trailingText: '${ewFilterController.inactiveEWCount}',
        ),
      ],
      if (ewFilterController.hasClosable) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: ewFilterController.closableEWCount / ewFilterController.openedEWCount,
          color: noInfoColor,
          titleText: loc.ew_filter_no_opened_tasks,
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
          titleText: loc.ew_filter_ok,
          trailingText: '${ewFilterController.okEWCount}',
        ),
      ],
    ]);
  }
}
