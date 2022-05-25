// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_progress.dart';
import '../../extra/services.dart';
import '../../presenters/ew_overall_state_presenter.dart';

//TODO: вытащить отсюда всё, что можно в SmartableDashboard, либо сделать универсальный виджет для целей и задач из этого

class MainDashboard extends StatelessWidget {
  int get _riskyGoalsCount => ewFilterController.riskyEW.length;
  int get _overdueGoalsCount => ewFilterController.overdueEW.length;
  int get _closableGoalsCount => ewFilterController.closableEW.length;
  int get _openedGoalsCount => ewFilterController.openedEW.length;
  int get _inactiveGoalsCount => ewFilterController.inactiveEW.length;
  int get _noDueGoalsCount => ewFilterController.noDueEW.length;
  int get _okGoalsCount => ewFilterController.okEW.length;
  bool get _hasOverdue => _overdueGoalsCount > 0;
  bool get _hasRisk => _riskyGoalsCount > 0;

  @override
  Widget build(BuildContext context) {
    final noInfoColor = stateColor(OverallState.noInfo);

    return Column(children: [
      if (_hasOverdue) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _overdueGoalsCount / _openedGoalsCount,
          color: stateColor(OverallState.overdue) ?? dangerColor,
          titleText: loc.ew_overdue_items,
          trailingText: '$_overdueGoalsCount',
          subtitleText: stateTextDetails(OverallState.overdue, overduePeriod: ewFilterController.overduePeriod),
        ),
      ],

      if (_hasRisk) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _riskyGoalsCount / _openedGoalsCount,
          color: stateColor(OverallState.risk) ?? riskyColor,
          titleText: loc.ew_risky_items,
          trailingText: '$_riskyGoalsCount',
          subtitleText: stateTextDetails(OverallState.risk, etaRiskPeriod: ewFilterController.riskPeriod),
        ),
      ],
      //TODO: добавить неосновные статусы для Smartable
      if (_noDueGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _noDueGoalsCount / _openedGoalsCount,
          color: noInfoColor,
          titleText: loc.ew_no_due_items,
          trailingText: '$_noDueGoalsCount',
        ),
      ],
      if (_inactiveGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _inactiveGoalsCount / _openedGoalsCount,
          color: noInfoColor,
          titleText: loc.ew_no_progress_items,
          trailingText: '$_inactiveGoalsCount',
        ),
      ],
      if (_closableGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _closableGoalsCount / _openedGoalsCount,
          color: noInfoColor,
          titleText: loc.ew_no_opened_tasks_items,
          trailingText: '$_closableGoalsCount',
        ),
      ],
      // TODO: напрашивается количество запасных дней. Но при наличии рисковых целей, то лучше показывать сумму за вычетом отстающих дней.
      // TODO: Тогда путаница получается... Подумать, как учитывать суммарное отставание или запасы в днях
      if ((_hasOverdue || _hasRisk) && _okGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _okGoalsCount / _openedGoalsCount,
          color: stateColor(OverallState.ok) ?? okColor,
          titleText: loc.ew_ok_items,
          trailingText: '$_okGoalsCount',
        ),
      ],
    ]);
  }
}
