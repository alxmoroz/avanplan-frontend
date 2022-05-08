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

enum _OverallState { overdue, badPace, goodPace, noInfo }

class _MainDashboardViewState extends State<MainDashboardView> {
  int get _activeGoalsCount => goalController.activeGoals.length;
  int get _timeBoundGoalsCount => goalController.timeBoundGoals.length;
  int get _badGoalsCount => goalController.badPaceGoals.length;
  int get _goodGoalsCount => goalController.goodPaceGoals.length;
  int get _overdueGoalsCount => goalController.overdueGoals.length;
  int get _totalGoalsCount => goalController.goals.length;
  int get _closableGoalsCount => goalController.closableGoals.length;

  _OverallState get _overallState => _timeBoundGoalsCount > 0
      ? (_overdueGoalsCount > 0
          ? _OverallState.overdue
          : _badGoalsCount == 0
              ? _OverallState.goodPace
              : _OverallState.badPace)
      : _OverallState.noInfo;

  Color? get _dashboardColor => {
        _OverallState.overdue: bgWarningPaceColor,
        _OverallState.badPace: bgWarningPaceColor,
        _OverallState.goodPace: bgGoodPaceColor,
      }[_overallState];

  final double _iconSize = onePadding * 15;

  Widget get _statusIcon =>
      {
        _OverallState.overdue: overdueIcon(context, size: _iconSize),
        _OverallState.badPace: badPaceIcon(context, size: _iconSize),
        _OverallState.goodPace: goodPaceIcon(context, size: _iconSize),
      }[_overallState] ??
      noInfoIcon(context, size: _iconSize);

  // TODO: локализация
  String get _statusText =>
      {
        _OverallState.overdue: 'Есть просрочка',
        _OverallState.badPace: 'Есть риски',
        _OverallState.goodPace: 'Всё идёт по плану',
      }[_overallState] ??
      'Ставьте сроки, разделяйте цели на задачи';

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        body: Container(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // TODO: локализация
                      /// статус и комментарий
                      _statusIcon,
                      H2(_statusText, align: TextAlign.center),
                      SizedBox(height: onePadding),

                      /// статистика по статусу
                      if (_overallState != _OverallState.goodPace && _goodGoalsCount > 0)
                        NormalText('Успеваем: $_goodGoalsCount', align: TextAlign.center),
                      if (_badGoalsCount > 0) NormalText('Отстаём: $_badGoalsCount', align: TextAlign.center),
                      if (_overdueGoalsCount > 0) NormalText('Просрочено: $_overdueGoalsCount', align: TextAlign.center),

                      /// общая статистика
                      SizedBox(height: onePadding),
                      if (_activeGoalsCount > 0) SmallText('Живые цели: $_activeGoalsCount / $_totalGoalsCount', align: TextAlign.center),
                      if (_timeBoundGoalsCount > 0) SmallText('Указан срок: $_timeBoundGoalsCount', align: TextAlign.center),
                      if (_closableGoalsCount > 0) SmallText('Закрыты все задачи: $_closableGoalsCount', align: TextAlign.center),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
