// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/element_of_work.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/empty_data_widget.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../element_of_work/ew_overall_state.dart';
import 'main_dashboard.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

class _MainDashboardViewState extends State<MainDashboardView> {
  // TODO: добавлять рутовую невидимую цель (Smartable) и делать расчёты через неё?

  int get _timeBoundGoalsCount => filterController.timeBoundEW.length;
  int get _riskyGoalsCount => filterController.riskyEW.length;
  int get _overdueGoalsCount => filterController.overdueEW.length;
  int get _openedGoalsCount => filterController.openedEW.length;

  bool get _hasOverdue => _overdueGoalsCount > 0;
  bool get _hasRisk => _riskyGoalsCount > 0;

  OverallState get _overallState => _timeBoundGoalsCount > 0
      ? (_hasOverdue
          ? OverallState.overdue
          : _hasRisk
              ? OverallState.risk
              : OverallState.ok)
      : OverallState.noInfo;

  final double _iconSize = onePadding * 15;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTPage(
        isLoading: mainController.isLoading,
        navBar: _openedGoalsCount > 0 ? navBar(context, title: loc.goal_list_count(_openedGoalsCount)) : null,
        body: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              radius: 1,
              colors: [(stateBgColor(_overallState) ?? backgroundColor).resolve(context), backgroundColor.resolve(context)],
            ),
          ),
          child: SafeArea(
            top: false,
            bottom: false,
            child: _openedGoalsCount == 0
                ? EmptyDataWidget(
                    title: loc.goal_list_empty_title,
                    addTitle: loc.goal_title_new,
                    onAdd: () => goalController.addGoal(context),
                  )
                : ListView(
                    shrinkWrap: true,
                    children: [
                      /// статус и комментарий
                      stateIcon(context, _overallState, size: _iconSize),
                      H3(
                        stateTextTitle(_overallState),
                        align: TextAlign.center,
                        padding: EdgeInsets.symmetric(horizontal: onePadding),
                        color: stateColor(_overallState) ?? darkGreyColor,
                      ),
                      SizedBox(height: onePadding),

                      /// статистика по статусу
                      MainDashboard(),
                      SizedBox(height: onePadding),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
