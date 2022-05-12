// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/empty_widget.dart';
import '../../components/icons.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../goal/goals_progress_widget.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

enum _OverallState { overdue, risk, ok, noInfo }

class _MainDashboardViewState extends State<MainDashboardView> {
  int get _timeBoundGoalsCount => goalController.timeBoundGoals.length;
  int get _riskyGoalsCount => goalController.riskyGoals.length;
  int get _overdueGoalsCount => goalController.overdueGoals.length;
  int get _totalGoalsCount => goalController.goals.length;

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

  String get _statusText =>
      {
        _OverallState.overdue: loc.main_dashboard_status_overdue_title,
        _OverallState.risk: loc.main_dashboard_status_risky_title,
        _OverallState.ok: loc.main_dashboard_status_ok_title,
      }[_overallState] ??
      loc.main_dashboard_status_no_info_title;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: mainController.isLoading,
        navBar: _totalGoalsCount > 0 ? navBar(context, title: loc.main_dashboard_total_title(_totalGoalsCount)) : null,
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              colors: [(_dashboardColor ?? backgroundColor).resolve(context), backgroundColor.resolve(context)],
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: _totalGoalsCount < 1
                ? EmptyDataWidget(
                    title: loc.goal_list_empty_title,
                    addTitle: loc.goal_title_new,
                    onAdd: () => goalController.addGoal(context),
                  )
                : ListView(
                    shrinkWrap: true,
                    children: [
                      /// статус и комментарий
                      _statusIcon,
                      H2(_statusText, align: TextAlign.center, padding: EdgeInsets.symmetric(horizontal: onePadding)),
                      SizedBox(height: onePadding),

                      /// статистика по статусу
                      GoalsProgressWidget(),
                      SizedBox(height: onePadding),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
