// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../../L1_domain/entities/goals/smartable.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_progress.dart';
import '../../extra/services.dart';
import '../smartable/smartable_overall_state.dart';

//TODO: вытащить отсюда всё, что можно в SmartableDashboard, либо сделать универсальный виджет для целей и задач из этого

class MainDashboard extends StatelessWidget {
  int get _riskyGoalsCount => goalController.riskyGoals.length;
  int get _overdueGoalsCount => goalController.overdueGoals.length;
  int get _closableGoalsCount => goalController.closableGoals.length;
  int get _openedGoalsCount => goalController.openedGoals.length;
  int get _inactiveGoalsCount => goalController.inactiveGoals.length;
  int get _noDueGoalsCount => goalController.noDueGoals.length;
  int get _okGoalsCount => goalController.okGoals.length;
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
          titleText: loc.smart_state_overdue_goals,
          trailingText: '$_overdueGoalsCount',
          subtitleText: stateTextDetails(OverallState.overdue, overduePeriod: goalController.overduePeriod),
        ),
      ],

      if (_hasRisk) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _riskyGoalsCount / _openedGoalsCount,
          color: stateColor(OverallState.risk) ?? riskyColor,
          titleText: loc.smart_state_risky_goals,
          trailingText: '$_riskyGoalsCount',
          subtitleText: stateTextDetails(OverallState.risk, etaRiskPeriod: goalController.riskPeriod),
        ),
      ],
      //TODO: добавить неосновные статусы для Smartable
      if (_noDueGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _noDueGoalsCount / _openedGoalsCount,
          color: noInfoColor,
          titleText: loc.smart_state_no_due_goals,
          trailingText: '$_noDueGoalsCount',
        ),
      ],
      if (_inactiveGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _inactiveGoalsCount / _openedGoalsCount,
          color: noInfoColor,
          titleText: loc.smart_state_no_progress,
          trailingText: '$_inactiveGoalsCount',
        ),
      ],
      if (_closableGoalsCount > 0) ...[
        SizedBox(height: onePadding),
        SampleProgress(
          ratio: _closableGoalsCount / _openedGoalsCount,
          color: noInfoColor,
          titleText: loc.smart_state_no_opened_tasks,
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
          titleText: loc.smart_state_ok_goals,
          trailingText: '$_okGoalsCount',
        ),
      ],
    ]);
  }
}
