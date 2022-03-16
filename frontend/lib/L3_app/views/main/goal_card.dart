// Copyright (c) 2022. Alexandr Moroz

import 'package:flutter/material.dart';

import '../../../L1_domain/entities/goals/goal.dart';
import '../../components/card.dart';
import '../../components/colors.dart';
import '../../components/constants.dart';
import '../../components/text_widgets.dart';
import '../../extra/services.dart';
import '../../presenters/date_presenter.dart';

class GoalCard extends StatelessWidget {
  const GoalCard(this.goal);

  final Goal goal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => mainController.goToGoalView(goal),
      child: MTCard(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            if (goal.closedRatio != null)
              LinearProgressIndicator(
                value: goal.closedRatio,
                color: (goal.pace >= 0 ? greenPaceColor : warningColor).resolve(context),
                minHeight: 42,
                backgroundColor: Colors.transparent,
              ),
            Padding(
              padding: EdgeInsets.all(onePadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      H3(goal.title, color: darkGreyColor.resolve(context)),
                      // SmallText(dueDate),
                    ],
                  ),
                  SizedBox(height: onePadding * 2),
                  if (goal.tasksCount > 0)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        LightText('${goal.closedTasksCount} / ${goal.tasksCount}'),
                        SmallText(dateToString(goal.etaDate)),
                      ],
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
