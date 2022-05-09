// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/empty_widget.dart';
import '../../components/icons.dart';
import '../../components/progress.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

enum _OverallState { overdue, risk, ok, noInfo }

class _MainDashboardViewState extends State<MainDashboardView> {
  int get _inactiveGoalsCount => goalController.inactiveGoals.length;
  int get _timeBoundGoalsCount => goalController.timeBoundGoals.length;
  int get _noDueGoalsCount => goalController.noDueGoals.length;
  int get _riskyGoalsCount => goalController.riskyGoals.length;
  int get _okGoalsCount => goalController.okGoals.length;
  int get _overdueGoalsCount => goalController.overdueGoals.length;
  int get _totalGoalsCount => goalController.goals.length;
  int get _closableGoalsCount => goalController.closableGoals.length;
  int get _overdueInDays => goalController.overduePeriod.inDays;
  int get _riskInDays => goalController.riskPeriod.inDays;

  bool get _hasOverdue => _overdueGoalsCount > 0;
  bool get _hasRisk => _riskyGoalsCount > 0;

  _OverallState get _overallState => _timeBoundGoalsCount > 0
      ? (_hasOverdue
          ? _OverallState.overdue
          : _hasRisk
              ? _OverallState.risk
              : _OverallState.ok)
      : _OverallState.noInfo;

  Color? get _dashboardColor => {
        _OverallState.overdue: bgRiskyColor,
        _OverallState.risk: bgRiskyColor,
        _OverallState.ok: bgOkColor,
      }[_overallState];

  final double _iconSize = onePadding * 15;

  Widget get _statusIcon =>
      {
        _OverallState.overdue: overdueIcon(context, size: _iconSize),
        _OverallState.risk: badPaceIcon(context, size: _iconSize),
        _OverallState.ok: goodPaceIcon(context, size: _iconSize),
      }[_overallState] ??
      noInfoIcon(context, size: _iconSize);

  // TODO: локализация
  String get _statusText =>
      {
        _OverallState.overdue: 'Опаздываем',
        _OverallState.risk: 'Есть риски',
        _OverallState.ok: 'Всё идёт по плану',
      }[_overallState] ??
      'Ставьте сроки, разделяйте цели на задачи';

  Widget goalsProgress({required int goalsCount, required Color color, required List<Widget> texts}) => Column(children: [
        SizedBox(height: onePadding),
        MTProgress(
          ratio: goalsCount / _totalGoalsCount,
          color: color,
          bgColor: borderColor.withAlpha(42),
          padding: EdgeInsets.symmetric(horizontal: onePadding, vertical: onePadding / (texts.length)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: texts,
          ),
        ),
      ]);

  // TODO: локализация
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              colors: [(_dashboardColor ?? backgroundColor).resolve(context), backgroundColor.resolve(context)],
            ),
          ),
          child: SafeArea(
            child: goalController.goals.isEmpty
                ? EmptyDataWidget(
                    title: loc.goal_list_empty_title,
                    addTitle: loc.goal_title_new,
                    onAdd: () => goalController.addGoal(context),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: onePadding),
                      if (_totalGoalsCount > 0) H3(loc.goal_dashboard_total_title(_totalGoalsCount), align: TextAlign.center),

                      const Spacer(),

                      /// статус и комментарий
                      _statusIcon,
                      H2(_statusText, align: TextAlign.center),
                      SizedBox(height: onePadding * 2),

                      /// статистика по статусу
                      if (_hasOverdue)
                        goalsProgress(
                          goalsCount: _overdueGoalsCount,
                          color: warningColor,
                          texts: [
                            Row(children: [
                              LightText(loc.goal_dashboard_progress_overdue_title(_overdueGoalsCount)),
                              const Spacer(),
                              H3('$_overdueGoalsCount'),
                            ]),
                            SmallText('Общее превышение сроков в днях: $_overdueInDays'),
                          ],
                        ),

                      if (_hasRisk)
                        goalsProgress(
                          goalsCount: _riskyGoalsCount,
                          color: riskyColor,
                          texts: [
                            Row(children: [
                              LightText(loc.goal_dashboard_progress_risky_title(_riskyGoalsCount)),
                              const Spacer(),
                              H3('$_riskyGoalsCount'),
                            ]),
                            SmallText('Отставание в днях: $_riskInDays'),
                          ],
                        ),

                      if (_noDueGoalsCount > 0)
                        goalsProgress(
                          goalsCount: _noDueGoalsCount,
                          color: loaderColor,
                          texts: [
                            Row(children: [
                              const LightText('Без указания срока'),
                              const Spacer(),
                              H3('$_noDueGoalsCount'),
                            ]),
                          ],
                        ),

                      if (_inactiveGoalsCount > 0)
                        goalsProgress(
                          goalsCount: _inactiveGoalsCount,
                          color: loaderColor,
                          texts: [
                            Row(children: [
                              const LightText('Без прогресса'),
                              const Spacer(),
                              H3('$_inactiveGoalsCount'),
                            ]),
                          ],
                        ),

                      if (_closableGoalsCount > 0)
                        goalsProgress(
                          goalsCount: _closableGoalsCount,
                          color: loaderColor,
                          texts: [
                            Row(children: [
                              const LightText('Закрыты все задачи'),
                              const Spacer(),
                              H3('$_closableGoalsCount'),
                            ]),
                          ],
                        ),

                      if ((_hasOverdue || _hasRisk) && _okGoalsCount > 0) ...[
                        goalsProgress(
                          goalsCount: _okGoalsCount,
                          color: bgOkColor,
                          texts: [
                            Row(children: [
                              const LightText('Успеваем'),
                              const Spacer(),
                              H3('$_okGoalsCount'),
                            ]),
                            // TODO: напрашивается количество запасных дней. Но при наличии рисковых целей, то лучше показывать сумму за вычетом отстающих дней.
                            // TODO: Тогда путаница получается... Подумать, как учитывать суммарное отставание или запасы в днях
                          ],
                        ),
                      ],

                      const Spacer(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
