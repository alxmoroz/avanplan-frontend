// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/date_string_widget.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import 'goal_progress_widget.dart';

class GoalCard extends StatelessWidget {
  const GoalCard({required this.goal, this.alone = false, this.onTap});

  final Goal goal;
  final bool alone;
  final VoidCallback? onTap;

  Widget buildCardTitle() {
    return H3(alone ? goal.title : loc.tasks_title, color: darkGreyColor, maxLines: 2);
  }

  Widget buildTasksCount() {
    final tasksString = '${goal.closedTasksCount} / ${goal.tasksCount}';
    return H1(tasksString, padding: EdgeInsets.zero, color: darkGreyColor);
  }

  @override
  Widget build(BuildContext context) {
    return GoalProgressWidget(
      onTap: onTap,
      goal: goal,
      height: 112,
      middle: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildCardTitle(),
          if (goal.tasksCount > 0) buildTasksCount(),
        ],
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DateStringWidget(goal.dueDate, titleString: loc.common_due_date_label),
          SizedBox(height: onePadding),
          DateStringWidget(goal.etaDate, titleString: loc.common_eta_date_label),
        ],
      ),
    );
  }
}
