// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/constants.dart';
import '../../components/icons.dart';
import '../../components/mt_button.dart';
import '../../components/mt_page.dart';
import '../../components/navbar.dart';
import '../../extra/services.dart';
import '../smartable/smartable_dashboard.dart';
import 'goal_controller.dart';

class GoalDashboardView extends StatefulWidget {
  static String get routeName => 'goal_dashboard';

  @override
  _GoalDashboardViewState createState() => _GoalDashboardViewState();
}

class _GoalDashboardViewState extends State<GoalDashboardView> {
  GoalController get _controller => goalController;
  Goal? get _goal => _controller.selectedGoal;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => _goal != null
          ? MTPage(
              isLoading: _controller.isLoading,
              navBar: navBar(
                context,
                title: loc.goal_title,
                trailing: MTButton.icon(editIcon(context), () => _controller.editGoal(context, _goal), padding: EdgeInsets.only(right: onePadding)),
              ),
              body: SafeArea(
                top: false,
                bottom: false,
                child: SmartableDashboard(_goal!, onTap: () => taskViewController.showTask(context, null)),
              ),
            )
          : Container(),
    );
  }
}
