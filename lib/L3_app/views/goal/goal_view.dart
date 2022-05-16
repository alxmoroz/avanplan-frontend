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

class GoalView extends StatelessWidget {
  static String get routeName => 'goal';

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
                trailing: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    MTButton.icon(plusIcon(context), () => smartableViewController.addTask(context)),
                    SizedBox(width: onePadding * 2),
                    MTButton.icon(editIcon(context), () => _controller.editGoal(context, _goal)),
                    SizedBox(width: onePadding),
                  ],
                ),
              ),
              body: SafeArea(
                top: false,
                bottom: false,
                child: SmartableDashboard(_goal!),
              ),
            )
          : Container(),
    );
  }
}
