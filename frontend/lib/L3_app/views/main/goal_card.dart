// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../goal/goal_progress_widget.dart';

class GoalCard extends StatelessWidget {
  const GoalCard(this.goal);

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    const double cardHeight = 100;
    return GestureDetector(
      onTap: () => mainController.goToGoalView(goal),
      child: MTCard(
        body: GoalProgressWidget(
          goal: goal,
          height: cardHeight,
          header: H3(goal.title, color: darkGreyColor, maxLines: 2),
          footer: goal.tasksCount > 0 ? H3('${goal.closedTasksCount} / ${goal.tasksCount}', color: darkGreyColor, padding: EdgeInsets.zero) : null,
        ),
      ),
    );
  }
}
