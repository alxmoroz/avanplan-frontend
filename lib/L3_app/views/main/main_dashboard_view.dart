// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:hercules/L3_app/components/constants.dart';
import 'package:hercules/L3_app/components/icons.dart';

import '../../components/colors.dart';
import '../../components/cupertino_page.dart';
import '../../components/empty_widget.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';

class MainDashboardView extends StatefulWidget {
  static String get routeName => 'main_dashboard';

  @override
  _MainDashboardViewState createState() => _MainDashboardViewState();
}

class _MainDashboardViewState extends State<MainDashboardView> {
  int get _activeGoals => goalController.activeGoals.length;
  int get _activeTimeBoundGoals => goalController.activeTimeBoundGoals.length;
  int get _badGoalsCount => goalController.badPaceGoals.length;
  int get _goodGoalsCount => goalController.goodPaceGoals.length;
  int get _totalGoalsCount => goalController.goals.length;
  int get _closableGoalsCount => goalController.closableGoals.length;

  Color? get _dashboardColor => _activeTimeBoundGoals > 0 ? (_badGoalsCount == 0 ? dashboardGoodPaceColor : dashboardWarningPaceColor) : null;

  final double _iconSize = onePadding * 15;
  Widget get _mainIcon => _activeTimeBoundGoals > 0
      ? (_badGoalsCount == 0 ? goodPaceDashboardIcon(context, size: _iconSize) : badPaceDashboardIcon(context, size: _iconSize))
      : noInfoDashboardIcon(context, size: _iconSize);

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        bgColor: _dashboardColor,
        body: SafeArea(
          child: goalController.goals.isEmpty
              ? EmptyDataWidget(
                  title: loc.goal_list_empty_title,
                  addTitle: loc.goal_title_new,
                  onAdd: () => goalController.addGoal(context),
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // TODO: локализация
                    _mainIcon,
                    const H2('Побуждающий текст', align: TextAlign.center),
                    SizedBox(height: onePadding),
                    if (_goodGoalsCount > 0) NormalText('Успеваем: $_goodGoalsCount', align: TextAlign.center),
                    if (_badGoalsCount > 0) NormalText('Отстаём: $_badGoalsCount', align: TextAlign.center),
                    SizedBox(height: onePadding),
                    if (_activeGoals > 0) SmallText('Живые цели: $_activeGoals / $_totalGoalsCount', align: TextAlign.center),
                    if (_activeTimeBoundGoals > 0) SmallText('Из них со сроком: $_activeTimeBoundGoals', align: TextAlign.center),
                    if (_closableGoalsCount > 0) SmallText('Закрыты все задачи: $_closableGoalsCount', align: TextAlign.center),
                  ],
                ),
        ),
      ),
    );
  }
}
