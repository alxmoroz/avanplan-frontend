// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/colors.dart';
import '../../components/cupertino_page.dart';
import '../../components/icons.dart';
import '../../components/navbar.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'goal_card.dart';
import 'goal_edit_view.dart';

class GoalView extends StatefulWidget {
  static String get routeName => 'goal';

  @override
  _GoalViewState createState() => _GoalViewState();
}

class _GoalViewState extends State<GoalView> {
  Goal? get _goal => mainController.selectedGoal;

  Future editGoal() async {
    final goal = await showEditGoalDialog(context);
    if (goal != null) {
      mainController.updateGoal(goal);
      if (goal.deleted) {
        Navigator.of(context).pop();
      } else {
        mainController.selectGoal(goal);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) => MTCupertinoPage(
        navBar: navBar(context, title: _goal != null ? loc.goal_title : loc.goal_title_new, bgColor: darkBackgroundColor),
        children: [
          ListTile(
            title: H2(_goal!.title),
            subtitle: _goal!.description.isNotEmpty ? LightText(_goal!.description) : null,
            trailing: editIcon(context),
            onTap: editGoal,
            dense: true,
            visualDensity: VisualDensity.compact,
          ),
          GoalCard(goal: _goal!),
        ],
      ),
    );
  }
}
