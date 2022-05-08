// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/cupertino_page.dart';
import '../../components/empty_widget.dart';
import '../../components/icons.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

enum _OverallState { overdue, risk, ok, noInfo }

class _MainDashboardViewState extends State<MainDashboardView> {
  int get _activeGoalsCount => goalController.activeGoals.length;
  int get _timeBoundGoalsCount => goalController.timeBoundGoals.length;
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
        _OverallState.overdue: bgRiskyPaceColor,
        _OverallState.risk: bgRiskyPaceColor,
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
        _OverallState.overdue: 'Есть просрочка',
        _OverallState.risk: 'Есть риски',
        _OverallState.ok: 'Всё идёт по плану',
      }[_overallState] ??
      'Ставьте сроки, разделяйте цели на задачи';

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
                : Column(children: [
                    const Spacer(),

                    /// статус и комментарий
                    _statusIcon,
                    H2(_statusText),
                    SizedBox(height: onePadding),

                    // TODO: локализация

                    /// статистика по статусу
                    if (_hasOverdue) ...[
                      if (_overdueGoalsCount > 0) H3('Просроченные цели: $_overdueGoalsCount'),
                      if (_overdueInDays > 0) LightText('Общее превышение сроков в днях: $_overdueInDays'),
                      SizedBox(height: onePadding),
                    ],

                    if (_hasRisk) ...[
                      if (_riskyGoalsCount > 0) H3('Цели с риском отставания: $_riskyGoalsCount'),
                      if (_riskInDays > 0) LightText('Отставание в днях: $_riskInDays'),
                      SizedBox(height: onePadding),
                    ],

                    if ((_hasOverdue || _hasRisk) && _okGoalsCount > 0) NormalText('Успеваем: $_okGoalsCount'),

                    /// общая статистика
                    if (_activeGoalsCount > 0) SmallText('Живые цели: $_activeGoalsCount'),
                    if (_timeBoundGoalsCount > 0) SmallText('Указан срок: $_timeBoundGoalsCount'),
                    if (_closableGoalsCount > 0) SmallText('Закрыты все задачи: $_closableGoalsCount'),

                    const Spacer(),
                    if (_totalGoalsCount > 0) LightText('Всего целей: $_totalGoalsCount'),
                    SizedBox(height: onePadding),
                  ]),
          ),
        ),
      ),
    );
  }
}
