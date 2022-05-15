// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/mt_progress.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

//TODO: вытащить отсюда всё, что можно в SmartableDashboard, либо сделать универсальный виджет для целей и задач из этого

class MainDashboard extends StatelessWidget {
  int get _riskyGoalsCount => goalController.riskyGoals.length;
  int get _overdueGoalsCount => goalController.overdueGoals.length;
  int get _closableGoalsCount => goalController.closableGoals.length;
  int get _overdueInDays => goalController.overduePeriod.inDays;
  int get _riskInDays => goalController.riskPeriod.inDays;
  int get _openedGoalsCount => goalController.openedGoals.length;
  int get _inactiveGoalsCount => goalController.inactiveGoals.length;
  int get _noDueGoalsCount => goalController.noDueGoals.length;
  int get _okGoalsCount => goalController.okGoals.length;
  bool get _hasOverdue => _overdueGoalsCount > 0;
  bool get _hasRisk => _riskyGoalsCount > 0;

  Widget goalsProgress({
    required int goalsCount,
    required Color color,
    required String titleText,
    required String trailingText,
    String? subtitleText,
  }) =>
      Column(children: [
        SizedBox(height: onePadding),
        MTProgress(
          ratio: goalsCount / _openedGoalsCount,
          color: color,
          bgColor: darkBackgroundColor,
          padding: EdgeInsets.symmetric(horizontal: onePadding, vertical: onePadding / (subtitleText != null ? 2 : 1)),
          body: Row(children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LightText(titleText),
                  if (subtitleText != null) SmallText(subtitleText),
                ],
              ),
            ),
            H2(trailingText),
          ]),
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    const noInfoColor = borderColor;

    return Column(children: [
      if (_hasOverdue)
        goalsProgress(
          goalsCount: _overdueGoalsCount,
          color: warningColor,
          titleText: loc.main_dashboard_progress_overdue_title,
          trailingText: '$_overdueGoalsCount',
          subtitleText: '${loc.main_dashboard_progress_overdue_subtitle} ${loc.common_days_count(_overdueInDays)}',
        ),

      if (_hasRisk)
        goalsProgress(
          goalsCount: _riskyGoalsCount,
          color: riskyColor,
          titleText: loc.main_dashboard_progress_risky_title,
          trailingText: '$_riskyGoalsCount',
          subtitleText: '${loc.main_dashboard_progress_risky_subtitle} ${loc.common_days_count(_riskInDays)}',
        ),

      if (_noDueGoalsCount > 0)
        goalsProgress(
          goalsCount: _noDueGoalsCount,
          color: noInfoColor,
          titleText: loc.main_dashboard_progress_no_due_title,
          trailingText: '$_noDueGoalsCount',
        ),

      if (_inactiveGoalsCount > 0)
        goalsProgress(
          goalsCount: _inactiveGoalsCount,
          color: noInfoColor,
          titleText: loc.main_dashboard_progress_no_progress_title,
          trailingText: '$_inactiveGoalsCount',
        ),

      if (_closableGoalsCount > 0)
        goalsProgress(
          goalsCount: _closableGoalsCount,
          color: noInfoColor,
          titleText: loc.main_dashboard_progress_no_opened_tasks,
          trailingText: '$_closableGoalsCount',
        ),

      // TODO: напрашивается количество запасных дней. Но при наличии рисковых целей, то лучше показывать сумму за вычетом отстающих дней.
      // TODO: Тогда путаница получается... Подумать, как учитывать суммарное отставание или запасы в днях
      if ((_hasOverdue || _hasRisk) && _okGoalsCount > 0)
        goalsProgress(
          goalsCount: _okGoalsCount,
          color: bgOkColor,
          titleText: loc.main_dashboard_progress_ok_title,
          trailingText: '$_okGoalsCount',
        ),
    ]);
  }
}
